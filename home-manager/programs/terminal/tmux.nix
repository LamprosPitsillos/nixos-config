{
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "zt";
      runtimeInputs = with pkgs; [tmux zoxide fzf];
      text =
        /*
        bash
        */
        ''
          #--------------------------------------------------------------------#
          #                               CONFIG                               #
          #--------------------------------------------------------------------#

          DIR_LOOKUP_LIMIT=6

          #--------------------------------------------------------------------#
          #                                DIRS                                #
          #--------------------------------------------------------------------#


          # Function to check if a directory contains a .git folder
          has_git() {
              if [ -d "$1/.git" ]; then
                  echo "$1"
                  exit 0
              fi
          }

          # Function to search N paths upwards for a .git folder
          search_upwards() {
              if [ !  -d "$1" ];then exit 1; fi;
              dir="$1"
              count="$DIR_LOOKUP_LIMIT"
              while [ "$count" -gt 0 ]; do
                  has_git "$dir"
                  dir="$(dirname "$dir")"
                  count=$((count-1))
              done
              # echo "No .git directory found"
              echo "$1"
          }

          #--------------------------------------------------------------------#
          #                                NAME                                #
          #--------------------------------------------------------------------#

          project_name() {
              path="$1"
              basename "$path"
          }

          dir_name() {
              path="$1"
              basename "$path"
          }

          #--------------------------------------------------------------------#
          #                                MAIN                                #
          #--------------------------------------------------------------------#
          main() {
              if ! selected_path="$(zoxide query --interactive)" ; then exit 1; fi

              root_path="$(search_upwards "$selected_path")"

              session_name="$(project_name "$root_path")"
              window_name="$(dir_name "$selected_path")"

              # if tmux has session FOO then this will fall through and create a new window named BAR
              tmux new-session -d -s "$session_name" -n "$window_name" -c "$selected_path" || tmux new-window -t "$session_name" -n "$window_name" -c "$selected_path"
              tmux attach-session -t "$session_name"
          }

          main
        '';
    })
  ];
  programs.tmux = let
    primary_clipboard = "${pkgs.wl-clipboard}/bin/wl-copy --primary";
  in {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-q";
    terminal = "screen-256color";
    escapeTime = 0;
    historyLimit = 100000;
    mouse = true;

    extraConfig =
      /*
      tmux
      */
      ''
        set -g terminal-overrides ',xterm-256color:RGB'
        set -g focus-events on # TODO: learn how this works

        set -g detach-on-destroy off # don't exit from tmux when closing a session
        set -g renumber-windows on   # renumber all windows when any window is closed
        set -g set-clipboard on      # use system clipboard
        set -g status-interval 3     # update the status bar every 3 seconds
        set -g status-left "#[fg=blue,bold,bg=#1e1e2e]#{?client_prefix,#[reverse]  #[noreverse],  }  #S  "
        set -g status-right "#[fg=white,bold,bg=#1e1e2e]  #[fg=#b4befe,bold,bg=#1e1e2e]%a %Y-%m-%d #[fg=white,bold,bg=#1e1e2e]󱑒 #[fg=#b4befe,bold,bg=#1e1e2e]%l:%M %p"
        # set -ga status-right "#($HOME/.config/tmux/scripts/cal.sh)"
        set -g status-justify left
        set -g status-left-length 200    # increase length (from 10)
        set -g status-right-length 200    # increase length (from 10)
        set -g status-position top       # macOS / darwin style
        set -g status-style 'bg=#1e1e2e' # transparent
        # set -g window-status-current-format '#[fg=magenta,bg=#1e1e2e]#I #W#{?window_zoomed_flag,(),} '
        set -g window-status-current-format '#[fg=magenta,bg=#1e1e2e] #I:#W#{?window_zoomed_flag,( ),} '
        set -g window-status-format '#[fg=gray,bg=#1e1e2e] #I:#W '
        set -g window-status-last-style 'fg=white,bg=black'
        set -g default-terminal "''${TERM}"
        set -g message-command-style bg=default,fg=yellow
        set -g message-style bg=default,fg=yellow
        set -g mode-style bg=default,fg=yellow
        set -g pane-active-border-style 'fg=magenta,bg=default'
        set -g pane-border-style 'fg=brightblack,bg=default'

        #--------------------------------------------------------------------#
        #                              Keymaps                               #
        #--------------------------------------------------------------------#
        unbind S
        bind S source-file "$XDG_CONFIG_HOME/tmux/tmux.conf" \; display "Reloaded tmux conf"

        unbind v
        unbind x

        unbind % # Split vertically
        unbind '"' # Split horizontally

        bind v split-window -h -c "#{pane_current_path}"
        bind x split-window -v -c "#{pane_current_path}"
        bind c new-window -a -c "#{pane_current_path}"

        unbind r
        bind r command-prompt "rename-window '%%'"

        unbind k
        unbind &
        bind k kill-pane
        bind K kill-window

        #--------------------------------------------------------------------#
        #                                nvim                                #
        #--------------------------------------------------------------------#

        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

        bind -n 'M-h' if-shell "$is_vim" 'send-keys M-h' 'select-pane -L'
        bind -n 'M-j' if-shell "$is_vim" 'send-keys M-j' 'select-pane -D'
        bind -n 'M-k' if-shell "$is_vim" 'send-keys M-k' 'select-pane -U'
        bind -n 'M-l' if-shell "$is_vim" 'send-keys M-l' 'select-pane -R'

        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\\\'  'select-pane -l'"

        bind -n 'M-Space' if-shell "$is_vim" 'send-keys M-Space' 'select-pane -t:.+'

        bind -T copy-mode-vi 'M-h' select-pane -L
        bind -T copy-mode-vi 'M-j' select-pane -D
        bind -T copy-mode-vi 'M-k' select-pane -U
        bind -T copy-mode-vi 'M-l' select-pane -R
        bind -T copy-mode-vi 'M-\' select-pane -l
        bind -T copy-mode-vi 'M-Space' select-pane -t:.+

        unbind h
        unbind [
        bind h copy-mode

        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "${primary_clipboard}"
        bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "${primary_clipboard}"
      '';
  };
}

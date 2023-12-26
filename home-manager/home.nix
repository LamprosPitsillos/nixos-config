{ lib
, config
, pkgs
, inputs
, ...
}: {
  imports = [
    ./programs/tofi/tofi.nix
    ./programs/starship/starship.nix
    ./programs/eww/eww.nix
    ./programs/shell/zsh.nix
    ./programs/shell/fish.nix
    ./programs/wm/hyprland.nix
    ./programs/mpv/mpv.nix
    ./programs/qutebrowser/qutebrowser.nix
    ./programs/file_manager/yazi.nix
    ./programs/zathura/zathura.nix
    ./programs/kitty/kitty.nix
    ./programs/nvim/nvim.nix
  ];

  nixpkgs.overlays = [
    (final: prev: { nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }; })
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "inferno";
  home.homeDirectory = "/home/inferno";
  home.shellAliases = {
    nup = "sudo nixos-rebuild switch --flake /home/inferno/.nixos-config";
    nupb = "sudo nixos-rebuild boot --flake /home/inferno/.nixos-config";
    hup = "home-manager switch -b backup --flake /home/inferno/.nixos-config\#inferno";
    nconf = "nv /home/inferno/.nixos-config/nixos/configuration.nix";
    hconf = "nv /home/inferno/.nixos-config/home-manager/home.nix";

    btd = "bluetoothctl power off";
    btc = "bluetoothctl power on && bluetoothctl connect $(bluetoothctl devices | fzf --tac --reverse --height=30% --border | cut -d ' ' -f2)";
    ip = "ip -color=auto";
    # gtu = "cd ~/UoC/4ο\ Εξαμηνο";
    ls = "ls --sort time --color=auto -h";
    la = "eza --icons --long --accessed --all";
    lar = "eza --icons --long --accessed --all --tree --level ";
    tree = "eza --icons --tree --accessed";
    nv = "nvim";
    q = "exit";
    fm = "vifm .";
    se = "sudoedit";
    ytmp3 = ''
      ${lib.getExe pkgs.yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"
    '';
    ".." = "cd ..";
    "..." = "cd ../../";
    "...." = "cd ../../../";

    # GIT
    gco = "git checkout";
    gcl = "git clone";
    gdf = "git diff";
    gst = "git status";
    # Network
    nmqr = "nmcli dev wifi show-password";
  };


  programs.bat = {
    enable = true;
    config = {
      theme = "OneHalfDark";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    # options = [
    #   "--cmd"
    #   "cd"
    # ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "Lampros Pitsillos";
    userEmail = "hauahx@gmail.com";
    aliases = {
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
    };
    extraConfig = {
      credential.helper = "store";
      merge.conflictstyle = "diff3";
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  qt = {
    platformTheme = "gtk";
    enable = true;
    style.name = "adwaita";

    # detected automatically:
    # adwaita, adwaita-dark, adwaita-highcontrast,
    # adwaita-highcontrastinverse, breeze,
    # bb10bright, bb10dark, cde, cleanlooks,
    # gtk2, motif, plastique

    # style.package = pkgs.adwaita-qt6;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      package = pkgs.vimix-icon-theme;
      name = "Vimix";
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-q";
    terminal = "screen-256color";
    escapeTime = 0;
    historyLimit = 100000;
    mouse = true;

    extraConfig = /* tmux */ ''
      set-option -g terminal-overrides ',xterm-256color:RGB'
      set-option -g focus-events on # TODO: learn how this works

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

      bind-key -n 'M-h' if-shell "$is_vim" 'send-keys M-h' 'select-pane -L'
      bind-key -n 'M-j' if-shell "$is_vim" 'send-keys M-j' 'select-pane -D'
      bind-key -n 'M-k' if-shell "$is_vim" 'send-keys M-k' 'select-pane -U'
      bind-key -n 'M-l' if-shell "$is_vim" 'send-keys M-l' 'select-pane -R'

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\\\'  'select-pane -l'"

      bind-key -n 'M-Space' if-shell "$is_vim" 'send-keys M-Space' 'select-pane -t:.+'

      bind-key -T copy-mode-vi 'M-h' select-pane -L
      bind-key -T copy-mode-vi 'M-j' select-pane -D
      bind-key -T copy-mode-vi 'M-k' select-pane -U
      bind-key -T copy-mode-vi 'M-l' select-pane -R
      bind-key -T copy-mode-vi 'M-\' select-pane -l
      bind-key -T copy-mode-vi 'M-Space' select-pane -t:.+

      unbind h
      unbind [
      bind h copy-mode

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "${pkgs.wl-clipboard}/bin/wl-copy --primary"
    '';
  };


  # programs.zellij = {
  #
  #   enable = true;
  #   enableZshIntegration = false;
  #   settings = { };
  #
  # };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    defaultOptions = [
      "--height 40%"
      "--border"
    ];

    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d --max-depth 2";
    changeDirWidgetOptions = [ "--preview '${pkgs.eza}/bin/eza --icons --tree --accessed {} | head -200'" ];
    tmux.enableShellIntegration = true;
  };

  xdg.configFile."neovide/config.toml" = {
    enable = true;
    text = /* toml */ ''
      wsl = false
      no-multigrid = false
      vsync = true
      maximized = false
      srgb = false
      idle = true
      neovim-bin = "/usr/bin/env nvim" # in reality found dynamically on $PATH if unset
      frame = "Full"
    '';

  };
  xdg.configFile."newt/newt_colors" = {
    enable = true;
    text = ''
      root=white,black
      window=black,white
      title=black,lightgray
      label=black,lightgray
      acttextbox=white,black
      actbutton=white,black
      actlistbox=black,lightgray
      listbox=black,lightgray
      button=white,black
      actsellistbox=white,black
    '';
  };

  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    NEWT_COLORS_FILE = lib.mkIf config.xdg.configFile."newt/newt_colors".enable "${config.xdg.configHome}/newt/newt_colors";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

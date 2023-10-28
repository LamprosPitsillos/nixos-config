{ pkgs, ... }: {
  programs.kitty = let font_family = "JetBrainsMono NF"; in {
    enable = true;
    font = {
      package = pkgs.nerdfonts;
      name = font_family;
      size = 12;
    };
    keybindings = {
      "kitty_mod+s" = "paste_from_clipboard";
      "kitty_mod+v" = "paste_from_selection";
      "alt+shift+enter" = "clone-in-kitty --type=os-window";
    };
    extraConfig = ''
      modify_font underline_position 2
      modify_font underline_thickness 200%

      modify_font cell_width 100%
      modify_font cell_height -1px

      # # kitty-scrollback.nvim Kitten alias
      # action_alias kitty_scrollback_nvim kitten /home/inferno/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py --cwd /home/inferno/.local/share/nvim/lazy/kitty-scrollback.nvim/lua/kitty-scrollback/configs
      # # Browse scrollback buffer in nvim
      # map ctrl+shift+h kitty_scrollback_nvim
      # # Browse output of the last shell command in nvim
      # map ctrl+shift+g kitty_scrollback_nvim --config-file get_text_last_cmd_output.lua
      # # Show clicked command output in nvim
      # mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config-file get_text_last_visited_cmd_output.lua
    '';
    settings = {
      bold_font = "${font_family} Bold";
      italic_font = "${font_family} Italic";
      bold_italic_font = "${font_family} Bold Italic";
      disable_ligatures = "cursor";
      # scrollback_pager = ''
      # bash -c "exec nvim 63<&0 0</dev/null -u NONE -c 'map <silent> q :qa!<CR>' -c 'map <silent> i :qa!<CR>' -c 'set shell=bash scrollback=100000 termguicolors laststatus=0 cmdheight=0 noruler noshowmode noshowcmd clipboard+=unnamed' -c 'autocmd TermEnter * stopinsert' -c 'autocmd TermClose * call cursor(max([0,INPUT_LINE_NUMBER-1])+CURSOR_LINE, CURSOR_COLUMN)' -c 'terminal sed </dev/fd/63 -e \"s/'$'\x1b'']8;;file:[^\]*[\]//g\" && sleep 0.01 && printf \"'$'\x1b'']2;\"'"
      # '';
      copy_on_select = true;
      enable_audio_bell = false;
      window_alert_on_bell = false;
      bell_on_tab = false;
      window_margin_width = 0;
      background_opacity = 1;

      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";
    };

    shellIntegration.enableZshIntegration = true;
    shellIntegration.mode = "enabled";
    theme = "One Half Dark";
  };
}

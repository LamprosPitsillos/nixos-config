{pkgs,...}:{
programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerdfonts;
      name = "JetBrainsMono NF";
      size = 12;
    };
    keybindings = {
      "kitty_mod+s" = "paste_from_clipboard";
      "kitty_mod+v" = "paste_from_selection";
    };
    extraConfig = ''
      modify_font underline_position 2
      modify_font underline_thickness 200%

      modify_font cell_width 100%
      modify_font cell_height -1px
    '';
    settings = {
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
      allow_remote_control = true;
    };

    shellIntegration.enableZshIntegration = true;
    theme = "One Half Dark";
  };
    }

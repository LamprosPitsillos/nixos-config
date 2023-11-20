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
    ./programs/zsh/zsh.nix
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

  programs.bat = {
    enable = true;
    config = {
      theme = "OneHalfDark";
    };
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
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

    style.package = pkgs.adwaita-qt6;
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
escapeTime=0;
historyLimit=100000;
mouse=true;

extraConfig=''
set-option -g terminal-overrides ',xterm-256color:RGB'
set-option -g focus-events on # TODO: learn how this works

set -g detach-on-destroy off # don't exit from tmux when closing a session
set -g renumber-windows on   # renumber all windows when any window is closed
set -g set-clipboard on      # use system clipboard
set -g status-interval 3     # update the status bar every 3 seconds
set -g status-left "#[fg=blue,bold,bg=#1e1e2e]  #S  "
set -g status-right "#[fg=#b4befe,bold,bg=#1e1e2e]%a %Y-%m-%d 󱑒 %l:%M %p"
set -ga status-right "#($HOME/.config/tmux/scripts/cal.sh)"
set -g status-justify left
set -g status-left-length 200    # increase length (from 10)
set -g status-right-length 200    # increase length (from 10)
set -g status-position top       # macOS / darwin style
set -g status-style 'bg=#1e1e2e' # transparent
set -g window-status-current-format '#[fg=magenta,bg=#1e1e2e]*#I #W#{?window_zoomed_flag,(),} '
set -g window-status-format '#[fg=gray,bg=#1e1e2e] #I #W'
set -g window-status-last-style 'fg=white,bg=black'
set -g default-terminal "''${TERM}"
set -g message-command-style bg=default,fg=yellow
set -g message-style bg=default,fg=yellow
set -g mode-style bg=default,fg=yellow
set -g pane-active-border-style 'fg=magenta,bg=default'
set -g pane-border-style 'fg=brightblack,bg=default'
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
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--height 40%"
      "--border"
    ];
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

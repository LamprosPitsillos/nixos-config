{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./programs/tofi/tofi.nix
    ./programs/starship/starship.nix
    ./programs/eww/eww.nix
    ./programs/zsh/zsh.nix
    ./programs/wm/hyprland.nix
    ./programs/mpv/mpv.nix
    ./programs/qutebrowser/qutebrowser.nix
    # ./programs/dunst/dunst.nix
    ./programs/zathura/zathura.nix
    ./programs/kitty/kitty.nix
    ./programs/nvim/nvim.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "inferno";
  home.homeDirectory = "/home/inferno";

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
  home.file = {
  };

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
  };

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

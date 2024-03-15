{ lib
, config
, pkgs
, inputs
, ...
}: {
  imports = [
    ./programs/tofi/tofi.nix
    ./programs/starship/starship.nix
    ./programs/widgets/ags/ags.nix
    ./programs/widgets/eww/eww.nix
    ./programs/shell/zsh.nix
    ./programs/shell/fish.nix
    ./programs/wm/hyprland.nix
    ./programs/mpv/mpv.nix
    ./programs/media/image/ipqv.nix
    ./programs/qutebrowser/qutebrowser.nix
    ./programs/file_manager/yazi.nix
    ./programs/zathura/zathura.nix
    ./programs/terminal/kitty.nix
    ./programs/terminal/tmux.nix
    ./programs/nvim/nvim.nix
  ];

  nixpkgs.overlays = [
    (final: prev: { nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" "Lekton" "Mononoki" ]; }; })
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "inferno";
  home.homeDirectory = "/home/inferno";
  home.shellAliases = {
    nup = "sudo nixos-rebuild switch --flake /home/inferno/.nixos-config";
    nut = "sudo nixos-rebuild test --fast --flake /home/inferno/.nixos-config";
    nupb = "sudo nixos-rebuild boot --flake /home/inferno/.nixos-config";
    hup = "home-manager switch -b backup -I nixpkgs=flake:nixpkgs --flake /home/inferno/.nixos-config\#inferno";
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
  home.packages = with pkgs; [
    drawing
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  # qt = {
  #   platformTheme = "gtk";
  #   enable = true;
  #   style.name = "adwaita";
  #
  #   # detected automatically:
  #   # adwaita, adwaita-dark, adwaita-highcontrast,
  #   # adwaita-highcontrastinverse, breeze,
  #   # bb10bright, bb10dark, cde, cleanlooks,
  #   # gtk2, motif, plastique
  #
  #   # style.package = pkgs.adwaita-qt6;
  # };

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

  programs.fzf = {
    enable = true;
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
      frame = "full"
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

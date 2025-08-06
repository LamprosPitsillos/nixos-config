{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

let
  host = builtins.baseNameOf ./.;
in
{
  custom.hostProps.monitors = [
    {
      name = "eDP-1";
      primary = true;
      width = 1920;
      height = 1080;
      refreshRate = 60; # up to 144
    }
  ];

  environment.pathsToLink = [
    "/share/zsh"
    "/share/fish"
    "/share/nu"
  ];

  virtualisation.docker = {
    enableOnBoot = false;
    enable = true;
  };
  virtualisation.podman = {
    enable = true;
  };

  virtualisation.waydroid.enable = false;
  virtualisation.oci-containers.backend = "docker";

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev"; # or "nodev" for efi only
    efiInstallAsRemovable = true;
    configurationLimit = 10;
  };
  boot.loader.efi = {
    efiSysMountPoint = "/boot";
    # canTouchEfiVariables = true ;
  };
  boot.supportedFilesystems = [ "ntfs" ];
  #
  #
  # Define on which hard drive you want to install Grub.

  networking.hostName = host; # Define your hostname.
  networking.extraHosts = ''
    127.0.0.1   serve.maestro.test react.maestro.test maestro.test
  '';
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "el_GR.UTF-8/UTF-8"
    ];
  };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
    HISTFILE = "$XDG_CONFIG_HOME/zsh/.zsh_history";
    FLAKE_PATH = "$HOME/.nixos-config";

    GDK_BACKEND = lib.mkForce "wayland";
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
    TERMINAL = "kitty";

    NIXOS_CONFIG_PATH = "$HOME/.nixos-config";

    # Home cleanup
    NODE_REPL_HISTORY = "$XDG_DATA_HOME/node_repl_history";
    PYTHONHISTFILE = "$XDG_DATA_HOME/python_history";
    CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    MYSQL_HISTFILE = "$XDG_DATA_HOME/mysql_history";
    STARSHIP_CONFIG = "$XDG_CONFIG_HOME/starship/starship.toml";
  };

  programs.command-not-found.enable = false;

  programs.hyprland = {
    enable = true;
    withUWSM = false;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };
  programs.wireshark.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.inferno = {
    isNormalUser = true;
    extraGroups = [
      "wireshark"
      "docker"
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    initialPassword = "1234";

    packages = with pkgs; [

      chromium
      freecad-wayland

      # steam
      rare

      # godot_4
      man-pages
      man-pages-posix

      miniserve

      delta
      docker-compose
      # calibre
      easyeffects

      graphviz

      hplip

      # qemu
      wallust
      ledger
      typst
      qalculate-gtk
      numbat

      # hyprcursor

      ## MicroControllers
      # esptool

      # linuxKernel.packages.linux_6_4.perf
      inkscape
      transmission_4-gtk
      tesseract
      neovide
      # gtklock
      # Displays
      # nwg-displays
      # Screenshot - Screenrecord
      grim
      slurp
      swappy
      satty
      wl-screenrec

      # Desktop UX
      tofi
      ripdrag
      brightnessctl
      hyprpolkitagent
      hyprpicker

      # Networking
      bluetuith
      bluez
      iw
      networkmanagerapplet
      wget

      # Shell Utils
      p7zip
      qrencode
      ast-grep

      ffmpeg-full

      jq
      htmlq
      fq
      unzip
      zip
      parallel
      file
      bc
      tealdeer
      eza
      fd
      rlwrap
      hyperfine
      python311Packages.bpython

      # System Info
      acpi
      fastfetch
      libva-utils
      pciutils

      # Media Fetch
      yt-dlp

      # Communication
      discord
      thunderbird

      # Uni Notes Utils
      python311Packages.art
      socat
      wl-clipboard
      libreoffice

      # Media Editing
      darktable
      # hugin # Panorama creator
      gimp

      xplr
      libsForQt5.qtstyleplugins
      libsForQt5.qt5.qtwayland

      # swaynotificationcenter
      ncdu
      dust
      yazi
      fswatch
      udiskie

      # Images

      ### AI
      # https://github.com/NixOS/nixpkgs/pull/281048/files
      # rclip
      # (openai-whisper-cpp.override { cudaSupport = true; })
      # realesrgan-ncnn-vulkan
      # (ollama.override { acceleration = "cuda" ;})

      # Browsers
      qutebrowser
      firefox
      tor-browser

      exfat
      usbutils

      dash

      # Secrets
      pass-wayland

      # Programming Utils
      shellcheck
      tokei

      ## Dev Tools
      gef
      gdb
      gf

    ];
  };

  xdg = {
    portal.enable = true;
    portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    mime = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop";
        "application/zip" = "thunar.desktop";
        "application/vnd.rar" = "thunar.desktop";
        "application/x-7z-compressed" = "thunar.desktop";

        "image/jpeg" = "pqiv.desktop";
        "image/gif" = "pqiv.desktop";
        "image/webp" = "pqiv.desktop";
        "image/png" = "pqiv.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita";

    # detected automatically:
    # adwaita, adwaita-dark, adwaita-highcontrast,
    # adwaita-highcontrastinverse, breeze,
    # bb10bright, bb10dark, cde, cleanlooks,
    # gtk2, motif, plastique

    # style.package = pkgs.adwaita-qt6;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    (sweethome3d.application.overrideAttrs {
      env.ANT_ARGS = "-DappletClassSource=8 -DappletClassTarget=8 -DclassSource=8 -DclassTarget=8";
    })

    tenki
    # freecad
    radare2
    iaito

    geogebra
    mongodb-compass
    bottom

    libnotify
    vimix-gtk-themes
    vimix-icon-theme
    ripgrep
    ripgrep-all
    libsForQt5.qt5ct
    fzf
    ripdrag
    xcb-util-cursor

    ets

    xdg-user-dirs
    git
    ntfs3g

    wireshark

    nv-codec-headers

    pv

    hyprlock
    hypridle

    libinput
    wev

    # steam

    fuse-overlayfs

    brave
    (config.boot.kernelPackages.perf)
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts = {
    packages = [ pkgs.nerd-fonts.jetbrains-mono ];
  };
  # programs.zsh.enable = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

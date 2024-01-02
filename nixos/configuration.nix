# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ config
, pkgs
, inputs
, lib
, ...
}: {

  imports = [
    ./hardware-configuration.nix
    ./services.nix
  ];

  environment.pathsToLink = [ "/share/zsh" ];

  virtualisation.docker = {
    enable = true;
  };
  virtualisation.podman = {
    enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  nixpkgs.config.allowUnfree = true;

  # programs.home-manager.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  documentation = {
    dev.enable = true;
    nixos= {
        enable = true;
        includeAllModules =true;
    };
    man = {
      enable = true;
      generateCaches = true;
    };
  };
  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev"; # or "nodev" for efi only
    efiInstallAsRemovable = true;
  };
  boot.loader.efi = {
    efiSysMountPoint = "/boot";
    # canTouchEfiVariables = true ;
  };
  #
  #
  # Define on which hard drive you want to install Grub.

  networking.hostName = "infernoPC"; # Define your hostname.
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
    STARSHIP_CONFIG = "$XDG_CONFIG_HOME/starship/starship.toml";
    FLAKE_PATH = "$HOME/.nixos-config";
    SCRIPTS = "$FLAKE_PATH/scripts";

    GDK_BACKEND = "wayland";
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
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };


  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = /* lua */
      ''
        bluez_monitor.properties = {
            ["bluez5.enable-sbc-xq"] = true,
            ["bluez5.enable-msbc"] = true,
            ["bluez5.enable-hw-volume"] = true,
            ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  nixpkgs.overlays = [
    (final: prev: { nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }; })
    (final: prev: { qutebrowser = prev.qutebrowser.override { enableWideVine = true; }; })
    (final: prev: { nwg-displays = prev.nwg-displays.override { hyprlandSupport = true; }; })
    (final: prev: { auto-cpufreq = prev.auto-cpufreq.overrideAttrs
     rec {
        _version = "1.9.9";
        version =  lib.warnIf (prev.auto-cpufreq.version != _version ) "Seems like auto-cpufreq has been updated!" _version;
        postInstall = ''
        # copy script manually
        cp scripts/cpufreqctl.sh $out/bin/cpufreqctl.auto-cpufreq

        # systemd service
        mkdir -p $out/lib/systemd/system
        cp scripts/auto-cpufreq.service $out/lib/systemd/system
        '';
        postPatch = ''
        substituteInPlace auto_cpufreq/core.py --replace '/opt/auto-cpufreq/override.pickle' /var/run/override.pickle
        '';
     };

    })
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.inferno = {
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    initialPassword = "1234";

    packages = with pkgs; [
      qrencode
      delta
      docker-compose
      calibre
      easyeffects
      ast-grep
      graphviz

      qemu
      wallust
      distrobox
      ledger
      typst
      p7zip
      # linuxKernel.packages.linux_6_4.perf
      inkscape
      sddm-chili-theme
      transmission-gtk
      ffmpeg
      tesseract
      neovide
      gtklock
      # Displays
      nwg-displays
      # Nix
      nix-tree
      nix-du
      nix-info
      nix-index
      prefetch-npm-deps
      nix-prefetch-git
      nix-prefetch
      nurl
      home-manager

      # Screenshot - Screenrecord
      grim
      slurp
      swappy
      wf-recorder
      wl-screenrec

      # Desktop UX
      tofi

      # Networking
      bluetuith
      bluez
      iw
      networkmanagerapplet

      # System Info
      acpi
      fastfetch
      libva-utils
      pciutils

      # Media Fetch
      yt-dlp

      # Communication
      discord

      # Uni Notes Utils
      ## Math
      # mathpix-snipping-tool
      python311Packages.art
      brightnessctl
      hyprpaper
      hyprpicker
      jq
      fq
      socat
      wl-clipboard
      libreoffice
      thunderbird
      eww-wayland
      darktable
      yazi
      # File Space
      ncdu

      (writeShellApplication {
        name = "dmenu";

        runtimeInputs = [ tofi ];

        text = ''
          tofi "$@"
        '';
      })
      (
        writeShellApplication {
          name = "screenshot_sh";

          runtimeInputs = [ hyprpicker tofi grim slurp swappy ];
          text =
            /*
            sh
            */
            ''
              name=$(echo | tofi --prompt-text="Name: " --require-match=false --height=8% | tr " " "_")
              [ -z "$name" ] && exit
              grim -g "$(slurp)" - | swappy -f - -o "$HOME/pics/Screenshot/$(date +'%Y-%m-%d_%H-%M-%S')_$name".png
            '';
        }
      )
      unzip
      parallel
      file
      xplr
      libsForQt5.qtstyleplugins
      libsForQt5.qt5.qtwayland
      ripdrag
      # File System Managment
      xfce.thunar
      xfce.thunar-volman
      swaynotificationcenter
      bc
      # Images
      imv
      rclip
      realesrgan-ncnn-vulkan

      # Browsers
      qutebrowser
      firefox
      tor-browser

      tealdeer

      exfat
      usbutils

      eza
      fd
      zathura
      dash
      gimp-with-plugins
      # Secrets
      pass-wayland

      # Programming Utils
      rlwrap
      hyperfine
      shellcheck
      tokei
      ## Dev Tools
      gdb
      gf
    ];
  };

  xdg = {
    portal.enable = true;
    portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    mime = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop";
        "application/zip" = "thunar.desktop";
        "application/vnd.rar" = "thunar.desktop";
        "application/x-7z-compressed" = "thunar.desktop";

        "image/jpeg" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "image/png" = "imv.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bottom
    libnotify
    vimix-gtk-themes
    vimix-icon-theme
    ripgrep
    qt5ct
    fzf
    ripdrag
    xcb-util-cursor

    xdg-user-dirs
    git
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts = {
    packages = with pkgs; [
      pkgs.nerdfonts
    ];
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

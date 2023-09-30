# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  environment.pathsToLink = ["/share/zsh"];

  security.pam.services.gtklock = {};

  virtualisation.waydroid.enable = true;
  virtualisation.docker = {
    enable = true;
  };
  virtualisation.podman = {
    enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  services.syncthing = {
    enable = false;
  };
  services.kanata = {
    enable = true;
    keyboards = {
      "homerow" = {
        devices = [];
        config = ''
          (defsrc
           esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 prnt slck del home pgup pgdn end
           `       1    2    3    4    5    6    7    8    9    0    -    =    bspc
           tab     q    w    e    r    t    y    u    i    o    p    [    ]    \
           caps    a    s    d    f    g    h    j    k    l    ;    '    ret
           lsft      z    x    c    v    b    n    m    ,    .    /    rsft       up
           lctl    lmet lalt           spc            ralt cmp  rctl        left down rght
          )

          (defalias
           num   (layer-while-held nums) ;; Bind 'num' to numpad Layer
           esc_ctrl   (tap-hold 200 200 esc lctl);; Bind esc to Ctrl when holding
          )

          (deflayer qwerty
           caps     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 prnt slck del home pgup pgdn end
           `       1    2    3    4    5    6    7    8    9    0    -    =    bspc
           tab     q    w    e    r    t    y    u    i    o    p    [    ]    \
           @esc_ctrl    a    s    d    f    g    h    j    k    l    ;    '    ret
           lsft      z    x    c    v    b    n    m    ,    .    /    rsft       up
           lctl    lmet lalt           spc            @num cmp  rctl        left down rght
          )

          (deflayer nums
           _     _   _   _   _   _   _   _   _   _   _  _  _ _ _ _ _ _ _ _
           _   _    _    _    _    _    _    _    _    _    _     _    _    _
           _   _    _    -    =    _    _    [    ]    \    _    _    _    _
           _   1    2    3    4    5    6    7    8    9    0   _    _
           _   _    _    _    _    _    _    _    _    _    _    _       _
           _    _  bspc                 ret              _ _  _        _ _ _

          )
        '';
      };
    };
  };
  nixpkgs.config.allowUnfree = true;

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  # programs.home-manager.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  documentation = {
    dev.enable = true;
    man = {
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
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:escape";
    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;
        theme = "chili";
      };
    };
  };
  security.polkit.enable = true;
  # services.xserver.windowManager.qtile.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text =
      /*
      lua
      */
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
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    nvidia = {
      # Modesetting is needed for most Wayland compositors
      modesetting.enable = true;
      # # Use the open source version of the kernel module
      # # Only available on driver 515.43.04+
      open = false;
      #
      powerManagement.enable = true;
      # # Enable the nvidia settings menu
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      driSupport = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };
  };
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  nixpkgs.overlays = [
    (final: prev: {nerdfonts = prev.nerdfonts.override {fonts = ["JetBrainsMono"];};})
    (final: prev: {qutebrowser = prev.qutebrowser.override {enableWideVine = true;};})
    (final: prev: {nwg-displays = prev.nwg-displays.override {hyprlandSupport = true;};})
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.inferno = {
    isNormalUser = true;
    extraGroups = ["docker" "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    initialPassword = "1234";

    packages = with pkgs; [
      qemu
      wallust
      distrobox
      ledger
      typst
      p7zip
      linuxKernel.packages.linux_6_4.perf
      inkscape
      ueberzugpp
      sddm-chili-theme
      transmission-gtk
      ffmpeg
      tesseract
      neovide
      gtklock
      figlet
      # Displays
      nwg-displays
      # Nix

      nix-index
      prefetch-npm-deps
      nix-prefetch-git
      nix-prefetch
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
      socat
      wl-clipboard
      libreoffice
      thunderbird
      eww-wayland
      darktable
      # File Space
      ncdu

      (writeShellApplication {
        name = "dmenu";

        runtimeInputs = [tofi];

        text = ''
          tofi "$@"
        '';
      })
      (
        writeShellApplication {
          name = "screenshot_sh";

          runtimeInputs = [hyprpicker tofi grim slurp swappy];
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
      parallel
      file
      trashy
      xplr
      libsForQt5.qtstyleplugins
      libsForQt5.qt5.qtwayland
      ripdrag
      # File System Managment
      xfce.thunar
      xfce.thunar-volman
      swaynotificationcenter
      bc
      vimiv-qt
      tectonic
      texlab
      lxappearance
      nil
      qutebrowser
      firefox
      tealdeer

      exfat
      usbutils

      eza
      rofi
      fd
      zathura
      dash
      gimp-with-plugins
      # Secrets
      pass-wayland

      # LSPs
      typstfmt
      typst-lsp
      typst-live
      cmake-language-server
      python311Packages.python-lsp-ruff
      python311Packages.python-lsp-server
      python311Packages.pylsp-rope
      lua-language-server
      ruff-lsp
      clang-tools_16
      nodePackages_latest.bash-language-server
      nodePackages_latest.vscode-langservers-extracted
      nodePackages_latest.typescript-language-server
      typescript
      quick-lint-js
      # Programming Utils
      hyperfine
      shellcheck
      ## Build Tools
      pkg-config
      meson
      cmake
      gdb
      gf
      ## Libs
      glib
    ];
  };

  # File system browsing deps
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;

  xdg = {
    portal.enable = true;
    portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    mime = {
      enable = true;
      defaultApplications = {
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
    neovim

    gnumake
    xdg-user-dirs
    git
    kitty
    wezterm
    vifm
    zoxide
    kanata
    clang
    gcc
    starship
  ];

  # systemd = {
  #   user.services.polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #         Type = "simple";
  #         ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #         Restart = "on-failure";
  #         RestartSec = 1;
  #         TimeoutStopSec = 10;
  #       };
  #   };
  # };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  fonts = {
    packages = with pkgs; [
      pkgs.nerdfonts
    ];
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

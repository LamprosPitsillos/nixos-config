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
  # File system browsing deps
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  security.pam.services.gtklock = {};

  virtualisation.waydroid.enable = true;

  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
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
           esc_ctrl   (tap-hold 150 150 esc lctl);; Bind esc to Ctrl when holding
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
           _    _ bspc           ret            _ _  _        _ _ _

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
  documentation.man.generateCaches = true;
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    ZDOTDIR = "$HOME/.config/zsh";
    HISTFILE = "$HOME/.config/zsh/.zsh_history";
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
    STARSHIP_CONFIG = "$HOME/.config/starship/starship.toml";
    TERMINAL = "kitty";
  };

  # Configure keymap in X11
  services.xserver.layout = "us";

  # services.xserver.displayManager.lightdm.greeters.gtk.enable =true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.autoNumlock = true;
  services.xserver.displayManager.sddm.theme = "chili";
  services.xserver.xkbOptions = "caps:escape";
  services.xserver.windowManager.qtile.enable = true;

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
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

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };

  # services.xserver.videoDrivers = ["nvidia"];
  hardware = {
      nvidia = {
# Modesetting is needed for most Wayland compositors
          modesetting.enable = true;
          # # Use the open source version of the kernel module
          # # Only available on driver 515.43.04+
          # open = false;
          #
          # # Enable the nvidia settings menu
          # nvidiaSettings = true;
          # prime = {
          #     offload = {
          #         enable = true;
          #         enableOffloadCmd = true;
          #     };
          #     intelBusId = "PCI:0:2:0";
          #     nvidiaBusId = "PCI:1:0:0";
          # };
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
    (final: prev: {qutebrowser = prev.qutebrowser.override {enableWideVine = true;};})
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.inferno = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    initialPassword = "1234";

    packages = with pkgs; [
      neovide
      gtklock
      # Displays
      nwg-displays

      # Nix
      nix-prefetch-git
      nix-prefetch
      home-manager
      # Screenshot - Screenrecord
      grim
      slurp
      swappy
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
# (   pkgs.python311Packages.buildPythonPackage {
#       pname = "pix2tex";
#       version = "0.1.2";
#       src = fetchFromGitHub {
#         owner = "lukas-blecher";
#         repo = "LaTeX-OCR";
#         rev = "e30a5e0ed5c6457bfc112f3979047b30d25f2ebf";
#         sha256 = "05zx6iwz277lhx2i61dfldb02klbxzyqsw6jf57nm2gsf04sqfhc";
#       };
#   propagatedBuildInputs = with pkgs.python311Packages; [
#         numpy
#         requests
#         tqdm
#         munch
#         torch
#         opencv
#         requests
#         einops
#         (
#          buildPythonPackage {
#          pname = "x-transformers";
#          version = "1.18.0";
#          src = fetchPypi {
#          pname = "x-transformers";
#          version = "1.18.0";
#          sha256 = "c06011a4c5ad92d0b126d4c082f41e86d230709f2bf6889e0be66eb8a57ab08e";
#          };
#
#          propagatedBuildInputs = [
# packaging
#          (
# buildPythonPackage rec {
# pname = "einops";
#   version = "0.6.1";
#   format = "pyproject";
#   src = fetchFromGitHub {
#     owner = "arogozhnikov";
#     repo = pname;
#     rev = "refs/tags/v${version}";
#     sha256 ="1h8p39kd7ylg99mh620xr20hg7v78x1jnj6vxwk31rlw2dmv2dpr";
#   };
# nativeBuildInputs = [ hatchling ];
#  disabledTests = [
#     # Tests are failing as mxnet is not pulled-in
#     # https://github.com/NixOS/nixpkgs/issues/174872
#     "test_all_notebooks"
#     "test_dl_notebook_with_all_backends"
#     "test_backends_installed"
#   ];
#  disabledTestPaths = [
#     "tests/test_layers.py"
#   ];
# }
#                  )
#           torch];
#          }
#
#         )
#         tokenizers
#         pillow
#         pyyaml
#         pandas
#         timm
#
# (buildPythonPackage rec {
#   pname = "albumentations";
#   version = "1.3.1";
#   format = "setuptools";
#
#   disabled = pythonOlder "3.7";
#
#   src = fetchPypi {
#     inherit pname version;
#     hash = "sha256-pqODiP5UbFaAcejIL0FEmOhsntA8CLWOeoizHPeiRMY=";
#   };
#
#   nativeBuildInputs = [
#     pythonRelaxDepsHook
#   ];
#
#   pythonRemoveDeps = [
#     "opencv-python"
#   ];
#
#   propagatedBuildInputs = [
#     numpy
#     opencv4
#     pyyaml
#     qudida
#     scikit-image
#     scipy
#   ];
#
#   nativeCheckInputs = [
#     pytestCheckHook
#   ];
#
#
#  disabledTestPaths = [
#     "tests/test_serialization.py"
#   ];
#
#   disabledTests = [
#     # this test hangs up
#     "test_transforms"
#   ];
#
#   pythonImportsCheck = [ "albumentations" ];
# })
#       ];
#     }
# )
      brightnessctl
      hyprpaper
      hyprpicker
      jq
      socat
      wl-clipboard
      libreoffice
      thunderbird
      eww-wayland

      (writeShellApplication {
        name = "dmenu";

        runtimeInputs = [tofi];

        text = ''
          tofi "$@"
        '';
      })
      libsForQt5.qtstyleplugins
      libsForQt5.qt5.qtwayland
      ripdrag
      # File System Managment
      xfce.thunar
      xfce.thunar-volman

      swaynotificationcenter
      sddm-chili-theme
      bc
      nsxiv
      vimiv-qt
      tectonic
      texlab
      lxappearance
      nil
      qutebrowser
      tldr
      exa
      rofi
      fd
      zathura
      dash
      gimp-with-plugins
      # Secrets
      pass-wayland
      # LSPs
      lua-language-server
      clang-tools_16
      nodePackages_latest.bash-language-server
      nodePackages_latest.vscode-langservers-extracted
      # Programming Utils
      hyperfine
      shellcheck
      ## Build Tools
      pkg-config
      meson
      cmake
      ## Libs
      glib
    ];
  };
  xdg.mime = {
    enable = true;
    defaultApplications = {
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
    qtile
    kitty
    vifm
    zoxide
    kanata
    clang
    gcc
    starship
  ];

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
      fira-code-nerdfont
      jetbrains-mono
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

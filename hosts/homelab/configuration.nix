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

  custom.hostProps.monitors = [ ];

  environment.pathsToLink = [
    "/share/fish"
    "/share/nu"
  ];
  boot = {

    # Enable ZFS support
    # supportedFilesystems = [ "zfs" ];

    # Optional: automatically import ZFS pools at boot
    # zfs.enable = true;
    # Use the GRUB 2 boot loader.
    loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev"; # or "nodev" for efi only
      efiInstallAsRemovable = true;
      configurationLimit = 10;
    };
    loader.efi = {
      efiSysMountPoint = "/boot";
      # canTouchEfiVariables = true ;
    };
    supportedFilesystems = [ "ntfs" ];
  };


  networking.hostName = host; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    bottom

    libnotify
    ripgrep
    ripgrep-all
    fzf
    ripdrag

    ets

    git
    ntfs3g

    libinput

    fuse-overlayfs

    perf
  ];

  services.openssh.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # programs.zsh.enable = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

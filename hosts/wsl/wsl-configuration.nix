{ config
, pkgs
, inputs
, lib
, ...
}: {

  networking.extraHosts = ''
              127.0.0.1   serve.maestro.test react.maestro.test maestro.test
  '';

  virtualisation.docker = {
        enabled = true;
  };

  environment.pathsToLink = [ "/share/fish" ];

  documentation = {
    dev.enable = true;
    nixos = {
      enable = true;
      includeAllModules = true;
    };
    man = {
      enable = true;
      generateCaches = true;
    };
  };

  networking.hostName = "nixosWSL"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "el_GR.UTF-8/UTF-8"
    ];
  };

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    FLAKE_PATH = "$HOME/.nixos-config";
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
    # TERMINAL = "kitty";

    NIXOS_CONFIG_PATH = "$HOME/.nixos-config";

    # Home cleanup
    NODE_REPL_HISTORY = "$XDG_DATA_HOME/node_repl_history";
    PYTHONHISTFILE = "$XDG_DATA_HOME/python_history";
    CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    MYSQL_HISTFILE = "$XDG_DATA_HOME/mysql_history";
    STARSHIP_CONFIG = "$XDG_CONFIG_HOME/starship/starship.toml";
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    tenki
    bottom
    libnotify
    ripgrep
    ripgrep-all
    fzf
    ripdrag
    docker-compose

    xdg-user-dirs
    git
    pv

    # steam

    fuse-overlayfs

    (config.boot.kernelPackages.perf)
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

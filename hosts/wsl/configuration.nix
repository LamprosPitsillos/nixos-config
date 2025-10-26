{
  lib,
  nixos-wsl,
  pkgs,
  ...
}:

let
  host = builtins.baseNameOf ./.;
in
{
  imports = [
  ];

  # https://nix-community.github.io/NixOS-WSL/options.html
  wsl = {
    enable = true;

    wslConf = {
      interop.appendWindowsPath = false;
      network.generateHosts = false;
    };
  };

  networking.hostName = host; # Define your hostname.

  networking.extraHosts = ''
    127.0.0.1   serve.maestro.test react.maestro.test maestro.test
  '';

  fonts = {
    packages = [ pkgs.nerd-fonts.jetbrains-mono ];
  };

  virtualisation.docker = {
    enable = true;
  };

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

  ##
  # Packages that are necessary for all users
  # of the host including root

  environment.systemPackages = with pkgs; [
    bottom
    ripgrep
    ripgrep-all
    fzf
    git
    pv
  ];

  programs.mtr.enable = true;

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

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.pathsToLink = [ "/share/fish" ];

  #
  #
  ##
}

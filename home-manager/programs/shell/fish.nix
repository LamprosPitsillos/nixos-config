{ pkgs
, config
, lib
, ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
        set fish_greeting # Disable greeting
        '';
  };
}

{ pkgs, ... }: {
  programs.eww = {
    package = pkgs.eww;
    enable = true;
    configDir = ./.;
  };
}

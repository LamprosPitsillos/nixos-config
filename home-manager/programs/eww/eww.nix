{pkgs, ...}: {
  programs.eww = {
    package = pkgs.eww-wayland;
    enable = true;
    configDir = ./.;
  };
}

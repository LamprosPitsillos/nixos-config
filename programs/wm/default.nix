{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./wm_shell/quickshell.nix
  ];
}

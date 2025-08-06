{ pkgs, lib,config, ... }:
{
    _imports = [
        ./hypridle.nix
        ./hyprland.nix
        ./hyprlock.nix
        ./hyprpaper.nix
    ];
}

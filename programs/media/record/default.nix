{ pkgs, ... }:
{

  imports = [
    ./obs.nix
  ];

  home.packages = with pkgs; [ ];
}

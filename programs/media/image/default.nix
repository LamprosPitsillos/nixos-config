{ pkgs, ... }:
{

  imports = [
    ./ipqv.nix
  ];

  home.packages = with pkgs; [ darktable ];
}

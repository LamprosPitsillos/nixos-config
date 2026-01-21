{ pkgs, ... }:
{

  imports = [
    ./ipqv.nix
  ];

  packages = with pkgs; [ darktable ];
}

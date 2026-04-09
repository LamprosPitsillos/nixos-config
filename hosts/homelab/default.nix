{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./configuration.nix
    ./users.nix
  ];
}

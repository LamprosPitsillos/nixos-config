{ ... }:
{
  imports = [
    ./services.nix
    ./hardware-configuration.nix
    ./configuration.nix
    ./users.nix

    ./virtualisation
  ];
}

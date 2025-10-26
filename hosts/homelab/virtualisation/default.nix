{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./home-assistant
    ./pihole
  ];
  virtualisation = {
    oci-containers = {
      backend = "docker";
    };
    docker = {
      enableOnBoot = true;
      enable = true;
    };
    podman = {
      enable = true;
    };
  };
}

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
    ./jellyfin
  ];

  virtualisation = {
    oci-containers = {
      backend = "docker";
    };
    docker = {
      enableOnBoot = true;
      enable = true;
    };
  };
}

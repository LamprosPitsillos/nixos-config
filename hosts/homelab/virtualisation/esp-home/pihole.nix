{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{

  # https://esphome.io/guides/getting_started_command_line/
  virtualisation.oci-containers.containers."esp-home" = {
    autoStart = true;
    image = "ghcr.io/esphome/esphome:2025.12";

    privileged = true;
    environment = {
      USERNAME = "INITIAL_USERNAME";
      PASSWORD = "INITIAL_PASSWORD";
    };

    volumes = [
      "/var/lib/esp-home:/config"
    ];

    capabilities = {
    };

    extraOptions = [
      "--network=host"
    ];

  };
}

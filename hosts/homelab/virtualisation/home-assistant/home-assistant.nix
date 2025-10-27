{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  # https://www.home-assistant.io/installation/linux
  virtualisation.oci-containers.containers."home-assistant" = {
    autoStart = true;
    image = "ghcr.io/home-assistant/home-assistant:stable";
    privileged = true;
    volumes = [
      "${config.environment.variables.XDG_CONFIG_HOME}/home-assistant:/config"
      "/etc/localtime:/etc/localtime:ro"
      "/run/dbus:/run/dbus:ro"
    ];

    # Environment variables
    environment = {
      TZ = "Europe/Athens"; # Set your timezone
    };

    capabilities = {
      NET_ADMIN = true;
      NET_RAW = true;
    };
    # Extra docker / podman run options to allow hardware passthrough etc.
    extraOptions = [

    ];

    # If you want to specify ports (only needed if not using --network=host)
    ports = [ "8123:8123" ];

  };
  #[Bluetooth - Home Assistant](https://www.home-assistant.io/integrations/bluetooth)
  services.dbus.implementation = "broker";
  # Open needed firewall ports if firewall is enabled
  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}

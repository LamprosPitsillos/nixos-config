{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  virtualisation.oci-containers.containers."home-assistant" = {
    autoStart = true;
    image = "ghcr.io/home-assistant/home-assistant:stable";

    volumes = [
      "${./config.yaml}:/config"
      "/etc/localtime:/etc/localtime:ro"
    ];

    # Environment variables
    environment = {
      TZ = "Europe/Athens"; # Set your timezone
    };

    # Extra docker / podman run options to allow hardware passthrough etc.
    extraOptions = [
      "--network=host"

      # Example device passthrough for USB dongle (modify your device path)
      # "--device=/dev/ttyACM0:/dev/ttyACM0"

      # If you want privileged mode, add
      # "--privileged"
    ];

    # If you want to specify ports (only needed if not using --network=host)
    # ports = [ "8123:8123" ];

    # Optionally dependencies, restart policy
    # If you want container to restart on failure
    restartPolicy = "always";
  };
  # Open needed firewall ports if firewall is enabled
  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}

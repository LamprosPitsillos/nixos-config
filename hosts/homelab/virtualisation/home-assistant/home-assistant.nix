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

    # Persisting configuration data
    volumes = [
      # Volume to store HA configuration
      "${./config.yaml}:/config"

      # Optionally map localtime if needed
      "/etc/localtime:/etc/localtime:ro"
    ];

    # Environment variables
    environment = {
      TZ = "Europe/Nicosia"; # Set your timezone
    };

    # Extra docker / podman run options to allow hardware passthrough etc.
    extraOptions = [
      # run in host network so that discovery + integrations work
      "--network=host"

      # Example device passthrough for USB dongle (modify your device path)
      "--device=/dev/ttyACM0:/dev/ttyACM0"

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

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

let
  username = builtins.baseNameOf ./.;
  hm = config.home-manager.users.${username}.config;

  name = "home-assistant";
  tag = "2026.2";
in
{
  # https://www.home-assistant.io/installation/linux
  virtualisation.oci-containers.containers.${name} = {
    autoStart = true;
    image = "ghcr.io/home-assistant/home-assistant:${tag}";
    privileged = true;
    volumes = [
      "${hm.xdg.configHome}/${name}:/config"
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
      "--network=host"
    ];
  };
  #[Bluetooth - Home Assistant](https://www.home-assistant.io/integrations/bluetooth)
  services.dbus.implementation = "broker";
  networking.firewall.allowedTCPPorts = [
    8123
  ];
}

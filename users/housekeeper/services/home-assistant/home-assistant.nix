{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  name = "home-assistant";
  port = toString config.services.${name}.config.http.server_port;
  hostname = "${name}.lampros.home";
in
{
  systemd.tmpfiles.rules = [
    "f ${config.services.home-assistant.configDir}/automations.yaml 0644 hass hass"
    "f ${config.services.home-assistant.configDir}/scenes.yaml 0644 hass hass"
    "f ${config.services.home-assistant.configDir}/scripts.yaml 0644 hass hass"
  ];

  #[Bluetooth - Home Assistant](https://www.home-assistant.io/integrations/bluetooth)
  services.dbus.implementation = "broker";

  services.${name} = {
    enable = true;
    extraPackages =
      python313Packages: with python313Packages; [
        gtts
      ];

    extraComponents = [
      "esphome"
      "wled"
      "climate"
      "history"
      "history_stats"
      "recorder"
      "logbook"
      "shopping_list"
      "analytics"
      "met"
      "tag"
      "mobile_app"
      "system_bridge"
      "webostv"
      "wake_on_lan"
      "smartthings"
      "bluetooth"
      "bthome"
      # Recommended for fast zlib compression
      # https://www.home-assistant.io/integrations/isal
      "isal"

    ];
    config = {
      "automation ui" = "!include automations.yaml";
      "scene ui" = "!include scenes.yaml";
      "script ui" = "!include scripts.yaml";
      homeassistant = {
        name = "Home";
        # latitude = "!secret latitude";
        # longitude = "!secret longitude";
        # elevation = "!secret elevation";
        unit_system = "metric";
        time_zone = "UTC";
      };
      # frontend = {
      #   themes = "!include_dir_merge_named themes";
      # };
      http = {
        use_x_forwarded_for = true;
        trusted_proxies = [ "127.0.0.1" ];
      };
      recorder = { };
      history = { };
      # feedreader.urls = [ "https://nixos.org/blogs.xml" ];
    };
  };
  services.caddy.virtualHosts."http://${hostname}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

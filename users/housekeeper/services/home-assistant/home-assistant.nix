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

  services.${name} = {
    enable = true;
    extraComponents = [
      "esphome"
      "wled"
      "shopping_list"
      "analytics"
      "met"
      "mobile_app"
      "webostv"
      "smartthings"

    ];
    config = {
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
      # feedreader.urls = [ "https://nixos.org/blogs.xml" ];
    };

  };
  services.caddy.virtualHosts."http://${hostname}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

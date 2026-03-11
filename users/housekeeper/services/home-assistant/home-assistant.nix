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
  url = "http://local.${name}.com";
in
{

  services.${name} = {
    enable = true;
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
      http = { };
      # feedreader.urls = [ "https://nixos.org/blogs.xml" ];
    };

  };
  services.caddy.virtualHosts."${url}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

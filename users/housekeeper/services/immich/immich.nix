{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  name = "immich";
  port = toString config.services.${name}.port;
  hostname = "${name}.lampros.home";
in
{

  services.${name} = {
    enable = true;
    accelerationDevices = null;
  };
  services.caddy.virtualHosts."http://${hostname}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

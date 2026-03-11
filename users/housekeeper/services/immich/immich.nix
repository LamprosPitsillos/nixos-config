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
in
{

  services.${name} = {
    enable = true;
    accelerationDevices = null;
  };
  services.caddy.virtualHosts."http://local.${name}.com" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

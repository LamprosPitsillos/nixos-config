{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  name = "adguardhome";
  port = toString config.services.${name}.port;
  url = "http://local.${name}.com";
in
{

  services.${name} = {
    enable = true;
  };

  services.caddy.virtualHosts."${url}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

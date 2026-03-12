{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  name = "mealie";
  port = toString config.services.${name}.port;
  url = "http://local.${name}.com";
in
{

  services.${name} = {
    enable = true;
    database.createLocally = true;
  };

  services.caddy.virtualHosts."${url}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

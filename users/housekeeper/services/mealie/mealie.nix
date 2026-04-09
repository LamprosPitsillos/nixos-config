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
  hostname = "${name}.lampros.home";
in
{

  services.${name} = {
    enable = true;
    database.createLocally = true;
  };

  services.caddy.virtualHosts."http://${hostname}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

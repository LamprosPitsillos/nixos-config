{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  name = "jellyfin";
  port = 8096;
  url = "http://local.${name}.com";
in
{
  services.${name} = {

    enable = true;
    hardwareAcceleration = {
      enable = true;
      type = "nvenc";
    };
  };
  services.caddy.virtualHosts."${url}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

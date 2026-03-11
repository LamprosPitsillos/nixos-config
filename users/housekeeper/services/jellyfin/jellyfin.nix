{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  name = "jellyfin";
  port = toString 8096;
  url = "http://local.${name}.com";
in
{
  services.${name} = {

    enable = true;
    # hardwareAcceleration = {
    #   enable = true;
    #   type = "nvenc";
    #   # ls -l /sys/class/drm/renderD*/device/driver
    #   device = "/dev/dri/renderD128";
    # };
  };
  services.caddy.virtualHosts."${url}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

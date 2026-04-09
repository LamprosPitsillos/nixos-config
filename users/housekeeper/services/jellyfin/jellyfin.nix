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
  hostname = "${name}.lampros.home";
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
  services.caddy.virtualHosts."http://${hostname}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

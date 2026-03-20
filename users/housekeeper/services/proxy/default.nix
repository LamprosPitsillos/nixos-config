{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [

  ];

  services.caddy = {
    enable = true;
    openFirewall = true;
    globalConfig = ''
      auto_https off
    '';
  };
}

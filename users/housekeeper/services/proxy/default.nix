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
    globalConfig = ''
      auto_https off
    '';
  };
}

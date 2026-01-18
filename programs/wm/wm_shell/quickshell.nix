{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  programs.quickshell = {
    enable = !osConfig.custom.hostProps.isHeadless;
    activeConfig = "bar";

    systemd.enable = true;
    configs = {

      bar = ./bar;

    };
  };
}

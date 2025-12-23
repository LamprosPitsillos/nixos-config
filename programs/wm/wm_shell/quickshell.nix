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
    configs = {

      bar = {

      };

    };
  };
}

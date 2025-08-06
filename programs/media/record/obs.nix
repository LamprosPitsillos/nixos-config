{
  pkgs,
config,
  osConfig,
  lib,
  ...
}:
let
  isHeadless = osConfig.custom.hostProps.isHeadless;
in
{
  config = {
    programs.obs-studio = {
      enable = !isHeadless; # true/false
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
      ];
    };

  warnings = lib.optionals (config.programs.obs-studio.enable && isHeadless) [
    "OBS Studio is enabled but monitors is empty."
  ];
  };
}

{
  pkgs,
  lib,
  config,
  osConfig,
  ...

}:
let
  isHeadless = osConfig.custom.hostProps.isHeadless;
in
{
  services.hyprpaper = {
    enable = !isHeadless;
    settings =
      let
        grass_field = pkgs.fetchurl {
          url = "https://images.pexels.com/photos/55766/pexels-photo-55766.jpeg?cs=srgb&dl=pexels-pierre-sudre-9695-55766.jpg&fm=jpg";
          hash = "sha256-oqxRzvKsihDz0FnKMoLcfbklSjTG91Y5Rwnb5rRUDdU=";
          name = "grass_field";
        };
        sea = pkgs.fetchurl {
          url = "https://images.pexels.com/photos/1646311/pexels-photo-1646311.jpeg?cs=srgb&dl=pexels-muffin-1646311.jpg&fm=jpg";
          hash = "sha256-HAIf2czDDcLYgUO88POPl1u/YyIm9PUsT7gHDPtW0EM=";
          name = "sea";
        };
      in
      {
        splash = false;

        preload = builtins.map builtins.toString [
          grass_field
          sea
        ];

        wallpaper = [
          "eDP-1,${grass_field}"
          "HDMI-A-1,${sea}"
        ];
      };
  };
}

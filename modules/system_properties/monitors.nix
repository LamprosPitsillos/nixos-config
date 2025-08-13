{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.custom.hostProps = {
    monitors = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              example = "eDP-1";
              description = "The X11/Wayland identifier for the monitor (e.g., eDP-1, HDMI-1).";
            };
            primary = mkOption {
              type = types.bool;
              default = false;
              description = "Whether this monitor is the primary display (exactly one must be primary).";
            };
            width = mkOption {
              type = types.int;
              example = 1920;
              description = "The horizontal resolution of the monitor in pixels.";
            };
            height = mkOption {
              type = types.int;
              example = 1080;
              description = "The vertical resolution of the monitor in pixels.";
            };
            refreshRate = mkOption {
              type = types.int;
              default = 60;
              description = "The refresh rate of the monitor in Hz.";
            };
            x = mkOption {
              type = types.int;
              default = 0;
              description = "The X coordinate (offset in pixels) of the monitor's top-left corner in the virtual display layout.";
            };
            y = mkOption {
              type = types.int;
              default = 0;
              description = "The Y coordinate (offset in pixels) of the monitor's top-left corner in the virtual display layout.";
            };
            scale = mkOption {
              type = types.float;
              default = 1.0;
              description = "Scaling factor for UI elements on this monitor (e.g., 1.0 for normal, 2.0 for HiDPI).";
            };
            enabled = mkOption {
              type = types.bool;
              default = true;
              description = "Whether the monitor is enabled in the configuration.";
            };
            wallpaper = mkOption {
              type = types.nullOr types.path;
              default = null;
              description = "Path to the wallpaper image for this monitor, or null for no wallpaper setting.";
            };
            workspace = mkOption {
              type = types.nullOr types.str;
              default = null;
              description = "The default workspace assigned to this monitor, or null for no specific assignment.";
            };
          };
        }
      );
      default = [ ];
      description = "A list of monitor configurations, including resolution, position, scaling, and workspace mapping.";
    };
    isHeadless = mkOption {
      type = types.bool;
      internal = true; # This is not meant to be set by the user.
      description = "Whether the host has no connected or configured monitors (automatically set).";
    };
  };
  config = {
    custom.hostProps.isHeadless = config.custom.hostProps.monitors == [ ];
    assertions = [
      {
        assertion =
          ((lib.length config.custom.hostProps.monitors) != 0)
          -> ((lib.length (lib.filter (m: m.primary) config.custom.hostProps.monitors)) == 1);
        message = "Exactly one monitor must be set to primary.";
      }
    ];
  };
}

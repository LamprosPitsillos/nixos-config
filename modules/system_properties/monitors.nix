# https://github.com/Misterio77/nix-config/blob/main/modules/home-manager/monitors.nix
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
            };
            primary = mkOption {
              type = types.bool;
              default = false;
            };
            width = mkOption {
              type = types.int;
              example = 1920;
            };
            height = mkOption {
              type = types.int;
              example = 1080;
            };
            refreshRate = mkOption {
              type = types.int;
              default = 60;
            };
            x = mkOption {
              type = types.int;
              default = 0;
            };
            y = mkOption {
              type = types.int;
              default = 0;
            };
            scale = mkOption {
              type = types.float;
              default = 1.0;
            };
            enabled = mkOption {
              type = types.bool;
              default = true;
            };
            wallpaper = mkOption {
              type = types.nullOr types.path;
              default = null;
            };
            workspace = mkOption {
              type = types.nullOr types.str;
              default = null;
            };
          };
        }
      );
      default = [ ];
    };
    isHeadless = mkOption {
      type = types.bool;
      internal = true; # This is not meant to be set by the user.
      description = "Does the host have no output to any monitors.";
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

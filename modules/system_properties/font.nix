# https://github.com/Misterio77/nix-config/blob/main/modules/home-manager/monitors.nix
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.custom.hostProps = {
  };
  config = {
    assertions = [
    ];
  };
}

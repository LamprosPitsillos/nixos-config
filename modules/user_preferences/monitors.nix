{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.custom.userPrefs = {
    wallpapers = mkOption {
      type = types.attrsOf ( types.path ) ;
      description = ''
        Named wallpaper paths to your wallpapers.

        The path can be in the users directory or nix store passing in the result of a derivation.
        ex.

        ```nix
        {
            my_most_awesome_wallpaper = ./Wallpaper.png;

            my_awesome_wallpaper = pkgs.fetchurl {
                url = "https://wallpaper.url";
                hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
                name = "my_awesome_wallpaper";
            };
        }
        ```
      '';
      default = {};
    };

  };
  config = {
    assertions = [
      # {
      #   assertion =
      #     ((lib.length config.monitors) != 0)
      #     -> ((lib.length (lib.filter (m: m.primary) config.monitors)) == 1);
      #   message = "Exactly one monitor must be set to primary.";
      # }
    ];
  };
}

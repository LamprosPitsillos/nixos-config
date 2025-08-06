{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) literalExpression mkOption types;

  validKeysyms = import ./validKeysyms.nix;
  isValidKey = key: (builtins.stringLength key == 1 || lib.elem key validKeysyms.keys);

  type_validKeysyms = lib.mkOptionType {
    name = "validKeysyms";
    description = "List of strings, where each is either a single key ( length 1 ) or in an allowed list of keysyms.";
    check = value:
      lib.isList value
      && builtins.all (x: lib.isString x && isValidKey x) value;
  };
in {
  # This section defines the new options that will be available in your configuration.nix
  options.custom.userPrefs = {
    # We create a new namespace `keybinds` to hold our definitions and functions.
    keybinds = {
      definitions = mkOption {
        type = types.attrsOf (types.submodule {
          # The `submodule` defines the "shape" of each individual keybinding.
          options = {
            keys = mkOption {
              type = type_validKeysyms;
              default = [];
              description = "A list of primary keys for the binding (e.g., ['c'], ['Return' 'KP_Enter']).";
              example = literalExpression ''["a" "b" "Return"]'';
            };

            description = mkOption {
              type = types.nullOr types.str; # This makes the option optional.
              default = null;
              description = "An optional description of what the keybinding is for.";
              example = "Open a new terminal window.";
            };
          };
        });

        default = {}; # If the user doesn't define any keybinds, it will be an empty set.
        description = "An attribute set of deconstructed keybinding definitions to be used across the system configuration.";

        example = literalExpression ''
          {
            "open-terminal" = {
              keys = [ "Return" ];
              description = "Launch a new terminal.";
            };
            "close-window" = {
              keys = [ "q" ];
              description = "Close the focused window.";
            };
          }
        '';
      };

      # This namespace will hold utility functions for manipulating keybind definitions.
      helpers = mkOption {
        type = types.attrs;
        internal = true; # This is not meant to be set by the user.
        description = "A set of helper functions for working with keybindings.";
      };
    };
  };

  # This section provides the implementation for the functions.
  config = {
    custom.userPrefs.keybinds.helpers = {
      # This helper function takes a list of modifiers and a base keybinding
      # definition, and returns a new attribute set with the modifiers included.
      # It takes the original binding and merges a new 'modifiers' attribute into it.
      #
      # Example Usage in another module:
      # let
      #   kb = config.keybinds;
      #   terminalBind = kb.definitions."open-terminal";
      #   modifiedBind = kb.helpers.withModifier [ "Mod" ] terminalBind;
      # in
      # # modifiedBind is now: { keys = [ "Return" ]; description = "..."; modifiers = [ "Mod" ]; }
      withModifiers = mods: binding: binding // {modifiers = lib.checkListOfEnum "Valid modifier keysyms" validKeysyms.mods mods mods;};
    };

    assertions = [
    ];
  };
}

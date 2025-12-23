{ lib }:

let
  # All units expressed in milliseconds
  units = {
    ms  = 1;
    s   = 1000;
    min = 60 * 1000;
    h   = 3600 * 1000;
    day = 24 * 3600 * 1000;
  };

  # Helper to check if a unit exists
  requireUnit = unit:
    if builtins.hasAttr unit units then
      builtins.getAttr unit units
    else
      throw "time.nix: unknown unit '${unit}'. Supported units: ${builtins.concatStringsSep ", " (builtins.attrNames units)}";

  # Generic converter, accepts integers or floats
  convertTime = value: fromUnit: toUnit:
    let
      # Nix converts ints to floats automatically when mixed with / or *
      fromFactor = requireUnit fromUnit;
      toFactor   = requireUnit toUnit;
      valueInMs  = value * fromFactor;
    in
      valueInMs / toFactor;

  # Convenience wrappers with default target units
  toSec = value: fromUnit: convertTime value fromUnit "s";
  toMs  = value: fromUnit: convertTime value fromUnit "ms";
  toMin = value: fromUnit: convertTime value fromUnit "min";
  toH   = value: fromUnit: convertTime value fromUnit "h";
  toDay = value: fromUnit: convertTime value fromUnit "day";

in {
  inherit units convertTime toSec toMs toMin toH toDay;
}


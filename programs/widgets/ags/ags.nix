{
  inputs,
  pkgs,
  ...
}: let
  ags = inputs.ags.packages.${pkgs.system};
in {
  # add the home manager module
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = false;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = ./config;

    # additional packages to add to gjs's runtime
    extraPackages = [
      ags.battery
      ags.hyprland
      ags.mpris
      ags.tray
      ags.wireplumber
      ags.network
      ags.notifd
    ];
  };
  home.packages = [
    ags.io
    ags.notifd
  ];
}

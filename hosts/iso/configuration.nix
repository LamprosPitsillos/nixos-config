{
  lib,
  pkgs,
  modulesPath,
  ...
}:
let
  scripts = (pkgs.callPackage ./scripts.nix { });
in
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    scripts.quick-disk-setup

  ];

}

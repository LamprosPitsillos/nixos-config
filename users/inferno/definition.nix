{ config, ... }:
let
  username = builtins.baseNameOf ./.;
in
{
  home-manager = {
    useGlobalPkgs = true;
    users."${username}" = ./home-manager.nix;
  };
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "dialout"
      "wheel"
    ]; # Enable ‘sudo’ for the user.
    initialPassword = "1234";
  };
}

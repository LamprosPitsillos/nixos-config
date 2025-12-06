{ pkgs, ... }:
{
  imports = [
    ./../nix/nix.nix
  ];

  environment.systemPackages = with pkgs; [
    powertop
  ];

  documentation = {
    dev.enable = true;
    nixos = {
      enable = true;
      includeAllModules = true;
    };
    man = {
      enable = true;
      # really slow for some reason...
      generateCaches = false;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}

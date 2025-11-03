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
      generateCaches = true;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}

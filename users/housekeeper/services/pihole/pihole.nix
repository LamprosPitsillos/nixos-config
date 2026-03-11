{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{

  services.pihole-web = {
    enable = true;
    ports = [ 80 ];
  };
  services.pihole-ftl.settings = {

  };

  # Firewall rules if your firewall is enabled
  networking.firewall.allowedTCPPorts = [
    53
    80
    443
  ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}

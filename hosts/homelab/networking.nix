{ config, pkgs, ... }:
let
  host = builtins.baseNameOf ./.;
in
{

  networking = {

    hostName = host; # Define your hostname.
    networkmanager.enable = false;
    enableIPv6 = false;

    useDHCP = false;

    interfaces.enp4s0f1 = {
      ipv4.addresses = [
        {
          address = "192.168.31.158";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = "192.168.31.1";

    nameservers = [
      "192.168.31.158"
      "127.0.0.1"
    ];

    nftables.enable = true;

    firewall = {
      enable = true;
      logRefusedConnections = true;
      # Always allow traffic from your Tailscale network
      trustedInterfaces = [ "tailscale0" ];
      # Allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  # 1. Enable the service and the firewall
  services.tailscale.enable = true;

  # 2. Force tailscaled to use nftables (Critical for clean nftables-only systems)
  # This avoids the "iptables-compat" translation layer issues.
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  # 3. Optimization: Prevent systemd from waiting for network online
  # (Optional but recommended for faster boot with VPNs)
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}

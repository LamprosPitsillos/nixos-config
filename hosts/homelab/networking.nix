{ config, pkgs, ... }:
let
  host = builtins.baseNameOf ./.;
in
{

  users.users.${host}.openssh = {
    authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzX5efY+WMjdQrkbVphp4RRWQVh8vypslOylE06uHA6"
    ];
  };
  networking = {

    hostName = host; # Define your hostname.
    networkmanager.enable = false;
    enableIPv6 = false;

    useDHCP = false;

    interfaces.eth0 = {
      ipv4.addresses = [
        {
          address = "192.168.31.150";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = "192.168.31.1";

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
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

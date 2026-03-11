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
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    enableIPv6 = false;
  };

  # 1. Enable the service and the firewall
  services.tailscale.enable = true;
  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;
    logRefusedConnections = true;
    # Always allow traffic from your Tailscale network
    trustedInterfaces = [ "tailscale0" ];
    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

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

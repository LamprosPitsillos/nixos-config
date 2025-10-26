{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  virtualisation.oci-containers.containers."pihole" = {
    autoStart = true;
    image = "pihole/pihole:latest";

    environment = {
      TZ = "Europe/Athens";
      # Sets the admin password. If not set, Pi-hole generates a random one
      FTLCONF_webserver_api_password = "init_password_1234";
      # Important for bridge networking: listen on all interfaces
      FTLCONF_dns_listeningMode = "all";
      # If using custom dnsmasq config, enable this
      # FTLCONF_misc_etc_dnsmasq_d = "true";
    };

    volumes = [
      # Persist Pi-hole configs
      "/var/lib/pihole:/etc/pihole"
      # Enable if you have custom dnsmasq configs
      # "/var/lib/dnsmasq:/etc/dnsmasq.d"
    ];

    # Container capabilities
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--cap-add=SYS_TIME"
      "--cap-add=SYS_NICE"
    ];

    # Ports (only needed if not using `--network=host`)
    ports = [
      "53:53/tcp"
      "53:53/udp"
      "80:80/tcp"
      "443:443/tcp"
      # Uncomment if Pi-hole will act as DHCP server
      # "67:67/udp"
      # Uncomment if Pi-hole should provide NTP
      # "123:123/udp"
    ];

    restartPolicy = "unless-stopped";
  };
  # Firewall rules if your firewall is enabled
  networking.firewall.allowedTCPPorts = [
    53
    80
    443
  ];
  networking.firewall.allowedUDPPorts = [ 53 ];
  # Add if using DHCP or NTP from Pi-hole:
  # networking.firewall.allowedUDPPorts = [ 53 67 123 ];
}

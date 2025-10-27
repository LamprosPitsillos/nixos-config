{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  # https://docs.pi-hole.net/docker/
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
      "${config.environment.variables.XDG_CONFIG_HOME}/pihole:/etc/pihole"
      # Enable if you have custom dnsmasq configs
      # "/var/lib/dnsmasq:/etc/dnsmasq.d"
    ];

    capabilities = {
      NET_ADMIN = true;
      SYS_TIME = true;
      SYS_NIC = true;
      NET_BIND_SERVICE = true;
      CHOWN = true;
    };
    # Container capabilities
    extraOptions = [
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

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  username = builtins.baseNameOf ./.;
  hm = config.home-manager.users.${username}.config;

  name = "jellyfin";
  tag = "10.11";
in
{
  virtualisation.oci-containers.containers.${name} = {
    autoStart = true;
    image = "jellyfin/jellyfin:${tag}";

    # user: uid:gid
    # user = "uid:gid";

    ports = [
      "8096:8096/tcp"
      "7359:7359/udp"
    ];

    volumes = [
      "${hm.xdg.configHome}/${name}:/config"
      "${hm.xdg.cacheHome}/${name}:/cache"

      "${hm.xdg.userDirs.videos}/${name}:/media"

      # "/path/to/fonts:/usr/local/share/fonts/custom:ro"
    ];

    # environment = {
    #   JELLYFIN_PublishedServerUrl = "http://example.com";
    # };

    # extraHosts = [
    #   "host.docker.internal:host-gateway"
    # ];

    # docker-compose: restart: unless-stopped
    restartPolicy = "unless-stopped";
  };

  networking.firewall.allowedTCPPorts = [
    8096
  ];
  networking.firewall.allowedUDPPorts = [
    7359
  ];
}

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  name = "adguardhome";
  port = toString config.services.${name}.port;
  hostname = "${name}.lampros.home";
in
{

  services.${name} = {
    enable = true;
    settings = {
      filtering = {
        rewrites = [
          {
            domain = "*.lampros.home";
            answer = "192.168.31.158";
            enabled = true;
          }
        ];
      };
      filters =
        map
          (url: {
            enabled = true;
            url = url;
          })
          [
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt"
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # The Big List of Hacked Malware Web Sites
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
          ];
    };
  };

  services.caddy.virtualHosts."http://${hostname}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
  networking.firewall = {

    allowedTCPPorts = [
      53
    ];
    allowedUDPPorts = [
      53
    ];
  };
}

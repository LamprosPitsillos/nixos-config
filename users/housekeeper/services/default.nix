{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  # NOTE: Since i only have one machine for homelabing , am not gonna bother
  # modularizing this config part... even though i really want to
  imports = [
    ./home-assistant
    ./immich
    ./paperless
    ./pihole
    ./jellyfin

    ./proxy
  ];

}

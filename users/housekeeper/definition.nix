{ pkgs, config, ... }:
let
  username = builtins.baseNameOf ./.;
in
{
  home-manager = {
    useGlobalPkgs = true;
    users."${username}" = ./home-manager.nix;
  };
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "dialout"
      "wheel"
    ]; # Enable ‘sudo’ for the user.
    initialPassword = "1234";
    packages = with pkgs; [

      # godot_4
      man-pages
      man-pages-posix

      miniserve

      delta
      docker-compose

      hplip

      numbat

      esptool

      # Networking
      bluetuith
      bluez
      iw
      wget

      # Shell Utils
      p7zip
      qrencode
      ast-grep

      ffmpeg-full

      jq
      htmlq
      fq
      unzip
      zip
      parallel
      file
      bc
      tealdeer
      eza
      fd
      rlwrap
      hyperfine
      # python314Packages.bpython

      # System Info
      acpi
      fastfetch
      libva-utils
      pciutils

      # Media Fetch
      yt-dlp

      ncdu
      dust
      yazi
      fswatch
      udiskie

      exfat
      usbutils

      dash

      # Secrets
      pass-wayland

      # Programming Utils
      shellcheck
      tokei

    ];
  };
}

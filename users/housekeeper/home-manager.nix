{ pkgs, config,osConfig, ... }:
let
  username = builtins.baseNameOf ./.;
in
{

  imports = [
    ./../../programs
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
    packages = with pkgs; [
      man-pages
      man-pages-posix

      ripdrag

      docker-compose
      delta

      numbat

      # Shell Utils
      p7zip
      qrencode

      jq
      htmlq
      fq
      unzip
      zip
      file
      bc
      tealdeer
      eza
      fd
      rlwrap
      hyperfine
      python311Packages.bpython

      # System Info
      acpi
      fastfetch
      libva-utils
      pciutils

      # Media Fetch
      yt-dlp

      socat

      ncdu
      dust
      yazi
      fswatch
      udiskie

      dash
    ];

  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    templates = null;
    publicShare = null;
    pictures = "${config.home.homeDirectory}/pics";
    videos = "${config.home.homeDirectory}/vids";
    music = "${config.home.homeDirectory}/music";
    documents = "${config.home.homeDirectory}/docs";
    download = "${config.home.homeDirectory}/downs";
  };
}

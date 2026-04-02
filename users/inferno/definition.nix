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
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    initialPassword = "1234";
    # Remove packages from here and add them to HomeManager per user
    packages = with pkgs; [

      chromium
      freecad-wayland

      # steam
      rare

      quickemu
      # godot_4
      man-pages
      man-pages-posix

      miniserve

      delta
      docker-compose
      # calibre
      easyeffects

      graphviz

      hplip

      # qemu
      wallust
      ledger
      typst
      qalculate-gtk
      numbat

      # hyprcursor

      ## MicroControllers
      # esptool

      inkscape
      transmission_4-gtk
      tesseract
      neovide
      # gtklock
      # Displays
      # nwg-displays
      # Screenshot - Screenrecord
      grim
      slurp
      swappy
      satty
      wl-screenrec

      # Desktop UX
      tofi
      ripdrag
      brightnessctl
      hyprpolkitagent
      hyprpicker

      # Networking
      bluetuith
      bluez
      iw
      networkmanagerapplet
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
      # python313Packages.bpython

      # System Info
      acpi
      fastfetch
      libva-utils
      pciutils

      # Media Fetch
      yt-dlp

      # Communication
      discord
      thunderbird

      # Uni Notes Utils
      python311Packages.art
      socat
      wl-clipboard
      libreoffice

      # Media Editing
      # TODO: Fails at build due to libsoup
      # darktable
      # hugin # Panorama creator
      gimp

      xplr
      libsForQt5.qtstyleplugins
      libsForQt5.qt5.qtwayland

      # swaynotificationcenter
      ncdu
      dust
      yazi
      fswatch
      udiskie

      # Images

      ### AI
      # https://github.com/NixOS/nixpkgs/pull/281048/files
      # rclip
      # (openai-whisper-cpp.override { cudaSupport = true; })
      # realesrgan-ncnn-vulkan
      # (ollama.override { acceleration = "cuda" ;})

      # Browsers
      qutebrowser
      firefox
      tor-browser

      exfat
      usbutils

      dash

      # Secrets
      pass-wayland

      # Programming Utils
      shellcheck
      tokei

      ## Dev Tools
      gef
      gdb
      gf

    ];
  };
}

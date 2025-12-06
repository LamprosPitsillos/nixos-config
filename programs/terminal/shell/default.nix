{
  lib,
  config,
  osConfig,
  pkgs,
  # , inputs
  ...
}:
{

  imports = [
    ./fish.nix
    ./nush.nix
    ./zsh.nix

    ./bat.nix
    ./fzf.nix
    ./direnv.nix
    ./zoxide.nix
    ./starship.nix
  ];

  home.shellAliases =
    let
      homeDir = config.home.homeDirectory;
      username = config.home.username;
      host = osConfig.networking.hostName;

      eza = lib.getExe pkgs.eza;

    in
    {
      nup = "sudo nixos-rebuild switch --flake ${homeDir}/.nixos-config#${host} && notify-send 'NixOs' 'System rebuilt'";
      nut = "sudo nixos-rebuild test --fast --flake ${homeDir}/.nixos-config";
      nupb = "sudo nixos-rebuild boot --flake ${homeDir}/.nixos-config";
      hup = "home-manager switch -b backup -I nixpkgs=flake:nixpkgs --flake ${homeDir}/.nixos-config\#${username} && notify-send 'NixOs' 'HomeManager rebuilt'";
      nconf = "nv ${homeDir}/.nixos-config/hosts/${host}/default.nix";
      hconf = "nv ${homeDir}/.nixos-config/users/${username}/default.nix";

      btd = "bluetoothctl power off";
      btc = "bluetoothctl power on && bluetoothctl connect $(bluetoothctl devices | fzf --tac --reverse --height=30% --border | cut -d ' ' -f2)";
      ip = "ip -color=auto";
      # gtu = "cd ~/UoC/4ο\ Εξαμηνο";
      ls = "${eza} --icons --git";
      ll = "${eza} --icons --git --long";
      la = "${eza} --icons --git --long --accessed --all";
      lar = "${eza} --icons --git --long --accessed --all --tree --level";
      tree = "${eza} --icons --tree --accessed";
      nv = "nvim";
      q = "exit";
      fm = "yazi .";
      se = "sudoedit";
      ytmp3 = ''
        ${lib.getExe pkgs.yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"
      '';
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";

      # GIT
      gco = "git checkout";
      gcl = "git clone";
      gdf = "git diff";
      gst = "git status";
      # Network
      nmqr = "nmcli dev wifi show-password";
      theme = ''wallust theme $(wallust theme --help | rg "possible values:" | sed -e "s/.*possible values:\(.*\)]/\1/" | tr , "\n" |fzf)'';
    };
}

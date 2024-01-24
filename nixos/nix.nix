{ pkgs, inputs, lib, ... }:
let
    pr-track = pkgs.writeShellApplication {
        name = "pr-track";
        runtimeInputs = with pkgs; [ htmlq curl ];
        text = ''
            [ $# != 1 ] && echo "No PR number given." && exit 1
            pr="$1"
            if [ -t 1 ] ; then
                yes="\x1b[32mY\x1b[0m"
                no="\x1b[31mN\x1b[0m"
            else
                yes="Y"
                no="N"
            fi
            curl "https://nixpk.gs/pr-tracker.html?pr=$pr" -s |
                htmlq 'ol' -t |
                sed --expression '/^ *$/d' |
                paste - - |
                sed -e '1s/.*\(".*"\).*/\1/g' \
                    -e '3s/  /  |-/' \
                    -e "s/⚪/$no/" \
                    -e "s/✅/$yes/"
        '';
    };
    nix-from = lang : pkgs.writeShellApplication {
        name = "${lang}2nix";
        runtimeInputs = with pkgs; [ alejandra ];
        text = ''
        if [ -t 0 ]; then
            if [ "$#" -ge 1 ]; then
                path="$1"
                case $1 in
                    /*|./*);;
                     *) path="./$1";;
                esac
                nix eval --impure --expr "builtins.from${lib.toUpper lang} (builtins.readFile $path)" | alejandra -q
            else
              echo "Usage: $0 <file_path>"
              echo "Please provide a file path or use input redirection."
            fi
        else
            input=$(cat)
            nix eval --impure --expr "builtins.from${lib.toUpper lang} '''$input'''" | alejandra -q
        fi
    '';
    };
  json2nix = nix-from "json" ;
  toml2nix = nix-from "toml" ;
  # yaml2nix = nix_from "yaml" ;
in
{

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      (final: prev: { vaapiIntel = prev.vaapiIntel.override { enableHybridCodec = true; }; })
      (final: prev: { nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" "Lekton" "Mononoki" ]; }; })
      (final: prev: { qutebrowser = prev.qutebrowser.override { enableWideVine = true; }; })
      (final: prev: { nwg-displays = prev.nwg-displays.override { hyprlandSupport = true; }; })
      (final: prev: {
        auto-cpufreq = prev.auto-cpufreq.overrideAttrs
          rec {
            _version = "1.9.9";
            version = lib.warnIf (prev.auto-cpufreq.version != _version) "Seems like auto-cpufreq has been updated!" _version;
            postInstall = ''
              # copy script manually
              cp scripts/cpufreqctl.sh $out/bin/cpufreqctl.auto-cpufreq

              # systemd service
              mkdir -p $out/lib/systemd/system
              cp scripts/auto-cpufreq.service $out/lib/systemd/system
            '';
            postPatch = ''
              substituteInPlace auto_cpufreq/core.py --replace '/opt/auto-cpufreq/override.pickle' /var/run/override.pickle
            '';
          };

      })
    ];

  };


  environment.systemPackages = with pkgs; [

    json2nix
    toml2nix
    # yaml2nix
    pr-track


    nix-tree
    nix-du
    nix-info
    nix-index
    prefetch-npm-deps
    nix-prefetch-git
    nix-prefetch
    nurl
    home-manager
  ];

}

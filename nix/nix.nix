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

# ====================================================
# ====================================================

  nix-diff = pkgs.writeShellApplication {
      name = "nix-diff";
      runtimeInputs = with pkgs; [ fd fzf ];
      text = ''
          from="$(fd 'system-' /nix/var/nix/profiles/ -j 1 | sort --reverse --version-sort | fzf)"
          base_from="$(basename "$from")"
          to="/nix/var/nix/profiles/system"
          sep=" ("

          printf "\033[1mFROM: %s\033[0m\n\n" "$base_from"
          nix store diff-closures "$from" "$to"  | column -t -s ':' -o "$sep"
      '';

  };
  hm-diff = pkgs.writeShellApplication {
      name = "hm-diff";
      runtimeInputs = with pkgs; [ fd fzf ];
      text = ''
          curr_user="$(whoami)"
          from="$(fd 'profile-' /nix/var/nix/profiles/per-user/"$curr_user" -j 1 | sort --version-sort --reverse | fzf)"
          base_from="$(basename "$from")"
          to="/nix/var/nix/profiles/per-user/$curr_user/profile"
          sep=" ("

          printf "\033[1mFROM: %s\033[0m\n\n" "$base_from"
          nix store diff-closures "$from" "$to" | column -t -s ':' -o "$sep"
      '';

  };
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
      (final: prev: { qutebrowser = prev.qutebrowser.override { enableWideVine = true; }; })
      (final: prev: { nwg-displays = prev.nwg-displays.override { hyprlandSupport = true; }; })
    ];

  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = false;
  };

  environment.systemPackages = with pkgs; [

    json2nix
    toml2nix

    pr-track

    hm-diff
    nix-diff

    nixpkgs-review
    nix-update
    nix-tree
    nix-du
    nix-info
    nix-index
    nix-init
    prefetch-npm-deps
    nurl
    nvd
    home-manager

    alejandra
  ];

}

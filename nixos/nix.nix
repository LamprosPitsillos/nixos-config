{  pkgs , inputs, lib }:
let
 json2nix = pkgs.writeShellApplication {
    name = "json2nix";
    runtimeInputs = with pkgs; [hjson alejandra];
    text = ''
      json=$(cat - | hjson -j 2> /dev/null)
      nix eval --expr "builtins.fromJSON '''$json'''" | alejandra -q
    '';
  };
  yaml2nix = pkgs.writeShellApplication {
    name = "yaml2nix";
    runtimeInputs = with pkgs; [yq alejandra];
    text = ''
      yaml=$(cat - | yq)
      nix eval --expr "builtins.fromJSON '''$yaml'''" | alejandra -q
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
    allowUnfree=true;
    };

overlays = [
    (final: prev: { vaapiIntel = prev.vaapiIntel.override { enableHybridCodec = true; };})
    (final: prev: { nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }; })
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
    yaml2nix


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

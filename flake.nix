{
  description = "NixOS Config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };
  outputs =
    { nixpkgs
    , home-manager
    , hyprland
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      # formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      formatter."${system}" = pkgs.nixpkgs-fmt;

      templates = {
        default = {
          path = ./templates/default;

          description = "A very basic starter flake";
        };
      };
      nixosConfigurations = {
        "infernoPC" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
          };
          modules = [
            ./nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "inferno" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            {
              nix.registry.nixpkgs.flake = nixpkgs;
            }
            # hyprland.homeManagerModules.default
            ./home-manager/home.nix
          ];
        };
      };
    };
}

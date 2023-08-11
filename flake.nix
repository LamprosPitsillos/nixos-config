{
  description = "NixOS Config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

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
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}

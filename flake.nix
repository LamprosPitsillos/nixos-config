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

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    ags.url = "github:Aylur/ags";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };
  outputs = {
    nixpkgs,
    home-manager,
    nixos-wsl,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
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
      "nixosWSL" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          {
            system.stateVersion = "24.05";
            wsl.enable = true;
          }
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
          # inputs.hyprland.homeManagerModules.default
          ./home-manager/home.nix
        ];
      };
      "dev-wsl" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          {
            nix.registry.nixpkgs.flake = nixpkgs;
          }
          ./home-manager/wsl.nix
        ];
      };
    };
  };
}

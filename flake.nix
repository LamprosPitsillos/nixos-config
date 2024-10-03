{
  description = "NixOS Config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NOTE: This will require your git SSH access to the repo.
    #
    # WARNING: Do NOT pin the `nixpkgs` input, as that will
    # declare the cache useless. If you do, you will have
    # to compile LLVM, Zig and Ghostty itself on your machine,
    # which will take a very very long time.
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      # inputs.nixpkgs-stable.follows = "nixpkgs";
      # inputs.nixpkgs-unstable.follows = "nixpkgs";
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
        specialArgs = {
          inherit system;
          inherit inputs;
        };
        modules = [
          nixos-wsl.nixosModules.default
          ./nixos/wsl-configuration.nix
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

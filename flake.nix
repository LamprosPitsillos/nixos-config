{
  description = "NixOS Config flake";
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcphub-nvim.url = "github:ravitemer/mcphub.nvim";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

  };
  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-wsl,
      nix-index-database,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      namesFromDirs =
        path: builtins.attrNames (nixpkgs.lib.filterAttrs (n: v: v == "directory") (builtins.readDir path));
      users = namesFromDirs ./users;
      hosts = namesFromDirs ./hosts;
    in
    {
      formatter."${system}" = pkgs.nixpkgs-fmt;

      templates = {
        default = {
          path = ./nix/templates/default;
          description = "A very basic starter flake";
        };
        python = {
          path = ./nix/templates/python;
          description = "A very basic python starter flake";
        };
      };
      nixosConfigurations = nixpkgs.lib.genAttrs hosts (
        host:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit system;
            inherit inputs;
            hostName = host;
          };

          modules = [

            (nixos-wsl.nixosModules.default)
            (home-manager.nixosModules.home-manager)
            ({
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs;
                  hostName = host;
                };
              };
            })

            ./share/hosts.nix
            ./modules/system_properties
            ./hosts/${host}
          ];
        }
      );

      # homeConfigurations = nixpkgs.lib.genAttrs users (
      #   user:
      #   home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;
      #
      #     extraSpecialArgs = {
      #       inherit inputs;
      #       userName = user;
      #     };
      #     modules = [
      #       (nix-index-database.homeModules.nix-index)
      #
      #       ./share/users.nix
      #       ./modules/user_preferences
      #       ./users/${user}
      #     ];
      #   }
      # );
    };
}

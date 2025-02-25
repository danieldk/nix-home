{
  inputs = {
    #alpinocorpus = {
    #  url = "github:rug-compling/alpinocorpus";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    #conllu-utils = {
    #  url = "github:danieldk/conllu-utils";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    #dwarffs = {
    #  url = "github:edolstra/dwarffs/83c13981993fa54c4cac230f2eec7241ab8fd0a9";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, home-manager, nixos-apple-silicon, nixpkgs, vscode-server }: {
    homeConfigurations.mac =
      let system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [ home/machines/mac.nix ];
    };

    nixosConfigurations = let
      commonModule = {
        # Use the pinned nixpkgs version for flake commands.
        nix.registry.nixpkgs.flake = nixpkgs;

        nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
      };
    in {
      lerisque = let
        system = "x86_64-linux";
      in nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          commonModule
          nixos/machines/lerisque.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.daniel = import home/machines/lerisque.nix;
          }
        ];
      };
      mindbender = let
        system = "x86_64-linux";
      in nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          commonModule
          nixos/machines/mindbender.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.daniel = import home/machines/mindbender.nix;
            home-manager.extraSpecialArgs = {
              inherit vscode-server;
            };
          }
        ];
      };
      nonagon = let
        system = "aarch64-linux";
      in nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          commonModule
          nixos-apple-silicon.nixosModules.apple-silicon-support
          nixos/machines/nonagon.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.daniel = import home/machines/nonagon.nix;
          }
        ];
      };

      builder = let
        system = "x86_64-linux";
      in nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          commonModule
          nixos/machines/builder.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.daniel = import home/machines/daniel-tgi-dev.nix;
          }
        ];
      };
      tgi-dev = let
        system = "x86_64-linux";
      in nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          commonModule
          nixos/machines/tgi-dev.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.daniel = import home/machines/daniel-tgi-dev.nix;
          }
        ];
      };
    };
  };
}

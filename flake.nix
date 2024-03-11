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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
  };

  outputs = { self, home-manager, nixpkgs }: {
    #overlays.scripts = import overlays/20-scripts.nix;

    nixosConfigurations = let
      commonModule = {
        # Use the pinned nixpkgs version for flake commands.
        nix.registry.nixpkgs.flake = nixpkgs;

        nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
      };
    in {
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
          }
        ];
      };
    };
  };
}

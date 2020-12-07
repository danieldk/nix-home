{
  inputs = {
    alpinocorpus = {
      url = "github:rug-compling/alpinocorpus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    conllu-utils = {
      url = "github:danieldk/conllu-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    crate2nix = {
      url = "github:kolloch/crate2nix/0.8.0";
      flake = false;
    };
    dwarffs = {
      url = "github:edolstra/dwarffs/83c13981993fa54c4cac230f2eec7241ab8fd0a9";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
  };

  outputs = { self, alpinocorpus, conllu-utils, crate2nix, dwarffs, home-manager, nixpkgs }: {
    overlays.scripts = import overlays/20-scripts.nix;

    nixosConfigurations.mindbender = let
      system = "x86_64-linux";
    in nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        dwarffs.nixosModules.dwarffs
        nixos/machines/mindbender.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.daniel = import home/machines/mindbender.nix;
          nixpkgs.overlays = [
            (final: prev: {
              alpinocorpus = alpinocorpus.defaultPackage.${system};
              conllu-utils = conllu-utils.defaultPackage.${system};
              crate2nix = final.callPackage crate2nix {};
            })
            self.overlays.scripts
          ];
        }
      ];
    };
  };
}

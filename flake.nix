{
  inputs = {
    crate2nix = {
      url = "github:kolloch/crate2nix/0.8.0";
      flake = false;
    };
    danieldk = {
      url = "github:danieldk/nix-packages";
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

  outputs = { self, crate2nix, danieldk, dwarffs, home-manager, nixpkgs }: {
    overlays.scripts = import overlays/20-scripts.nix;

    nixosConfigurations.mindbender = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
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
              danieldk = final.callPackage danieldk {};
              crate2nix = final.callPackage crate2nix {};
            })
            self.overlays.scripts
          ];
        }
      ];
    };
  };
}

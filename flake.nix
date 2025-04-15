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
    kolide-launcher = {
      url = "github:kolide/nix-agent/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    nixpak = {
      url = "github:nixpak/nixpak/960898f79e83aa68c75876794450019ddfdb9157";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs =
    {
      self,
      home-manager,
      nixos-apple-silicon,
      kolide-launcher,
      nix-flatpak,
      nixpak,
      nixpkgs,
      vscode-server,
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);

      homeConfigurations.mac =
        let
          system = "aarch64-darwin";
          pkgs = nixpkgs.legacyPackages.${system};
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ home/machines/mac.nix ];
        };

      nixosConfigurations =
        let
          overlays = [
            (self: super: {
              mkNixPak = nixpak.lib.nixpak {
                inherit (self) lib;
                pkgs = self;
              };
            })
            (import overlays/asdbctl.nix)
            (import overlays/fonts.nix)
            (import overlays/sandboxing.nix)
            (import overlays/fixup.nix)
            (import overlays/kopia-ui.nix)
            (import overlays/prusa-slicer.nix)
          ];
          commonModule = {
            # Use the pinned nixpkgs version for flake commands.
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
            nixpkgs.overlays = overlays;
          };
        in
        {
          lerisque =
            let
              system = "x86_64-linux";
            in
            nixpkgs.lib.nixosSystem {
              inherit system;

              modules = [
                commonModule
                kolide-launcher.nixosModules.kolide-launcher
                nixos/machines/lerisque.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.daniel = import home/machines/lerisque.nix;
                  home-manager.extraSpecialArgs.nix-flatpak = nix-flatpak;
                }
              ];
            };
          mindbender =
            let
              system = "x86_64-linux";
            in
            nixpkgs.lib.nixosSystem {
              inherit system;

              modules = [
                commonModule
                nixos/machines/mindbender.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.daniel = import home/machines/mindbender.nix;
                  home-manager.extraSpecialArgs = {
                    inherit vscode-server;
                  };
                }
              ];
            };
          nonagon =
            let
              system = "aarch64-linux";
            in
            nixpkgs.lib.nixosSystem {
              inherit system;

              modules = [
                commonModule
                nixos-apple-silicon.nixosModules.apple-silicon-support
                nixos/machines/nonagon.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.daniel = import home/machines/nonagon.nix;
                }
              ];
            };

          builder =
            let
              system = "x86_64-linux";
            in
            nixpkgs.lib.nixosSystem {
              inherit system;

              modules = [
                commonModule
                nixos/machines/builder.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.daniel = import home/machines/daniel-tgi-dev.nix;
                }
              ];
            };
          tgi-dev =
            let
              system = "x86_64-linux";
            in
            nixpkgs.lib.nixosSystem {
              inherit system;

              modules = [
                commonModule
                nixos/machines/tgi-dev.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.daniel = import home/machines/daniel-tgi-dev.nix;
                }
              ];
            };
        };
    };
}

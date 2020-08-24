{
  inputs = {
    danieldk = {
      url = "github:danieldk/nix-packages";
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs-channels/nixos-unstable-small";
    home-manager = {
      url = "github:rycee/home-manager";
      flake = false;
    };
  };

  outputs = { self, danieldk, home-manager, nixpkgs }: {
    foo = let
      overlays = self: super: {
        danieldk = nixpkgs.legacyPackages.${"x86_64-linux"}.callPackage danieldk {};
      };
      configuration = { pkgs, ...}: {
        nixpkgs.overlays = [ overlays ];
        imports = [ machines/mindbender.nix ];
      };
    in self.lib.homeManagerConfiguration {
      inherit configuration;
      #configuration = import machines/mindbender.nix;
    };

    lib = {
      homeManagerConfiguration = {
          configuration
        , system ? "x86_64-linux"
        , homeDirectory ? "/home/daniel"
        , username ? "daniel"
        , pkgs ? nixpkgs.legacyPackages.${system}
        , check ? true }:
      import "${home-manager}/modules" {
        inherit check pkgs;

        configuration = { ... }: {
          imports = [ configuration ];
          home = { inherit homeDirectory username; };
        };
      };
    };
  };
}

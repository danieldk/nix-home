let
  sources = import ./nix/sources.nix;
  nixpkgs-unstable = import sources.nixpkgs-unstable {};
in {
  allowUnfree = true;

  packageOverrides = pkgs: {
    danieldk = pkgs.recurseIntoAttrs (import sources.danieldk {
      inherit pkgs;
    });

    finalfusion = pkgs.recurseIntoAttrs (import sources.finalfusion {
      inherit pkgs;
    });

    home-manager = pkgs.callPackage "${sources.home-manager}/home-manager" {
      path = toString sources.home-manager;
    };

    mozilla = pkgs.callPackage "${sources.mozilla}/package-set.nix" {};

    rocm = let
      self = (import sources.rocm) (nixpkgs-unstable // self) nixpkgs-unstable;
    in self;

    sticker = pkgs.recurseIntoAttrs (import sources.sticker {
      inherit pkgs;
    });
  };
}

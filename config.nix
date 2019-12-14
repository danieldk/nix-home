let
  sources = import ./nix/sources.nix;
in {
  allowUnfree = true;

  packageOverrides = pkgs: {
    danieldk = pkgs.recurseIntoAttrs (import ./danieldk-nix-packages/default.nix {
      inherit pkgs;
    });

    finalfusion = pkgs.recurseIntoAttrs (import ./finalfusion/default.nix {
      inherit pkgs;
    });

    home-manager = pkgs.callPackage "${sources.home-manager}/home-manager" {
      path = toString sources.home-manager;
    };

    mozilla = pkgs.callPackage "${sources.mozilla}/package-set.nix" {};

    sticker = pkgs.recurseIntoAttrs (import ./sticker/default.nix {
      inherit pkgs;
    });
  };
}

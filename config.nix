{
  allowUnfree = true;

  packageOverrides = pkgs: {
    danieldk = pkgs.recurseIntoAttrs (import ./danieldk-nix-packages/default.nix {
      inherit pkgs;
    });

    finalfusion = pkgs.recurseIntoAttrs (import ./finalfusion/default.nix {
      inherit pkgs;
    });

    sticker = pkgs.recurseIntoAttrs (import ./sticker/default.nix {
      inherit pkgs;
    });
  };
}

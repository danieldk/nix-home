{
  allowUnfree = true;

  packageOverrides = pkgs: {
    danieldk = import ./danieldk-nix-packages/default.nix {
      inherit pkgs;
    };

    finalfusion = import ./finalfusion-overlay/default.nix {
      inherit pkgs;
    };
  };
}

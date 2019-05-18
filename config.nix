{
  allowUnfree = true;

  packageOverrides = pkgs: {
    danieldk = import ./danieldk-nix-packages/default.nix {
      inherit pkgs;
    };
  };
}

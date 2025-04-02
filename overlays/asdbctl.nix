final: prev: {

  asdbctl =
    let
      inherit (final)
        fetchFromGitHub
        lib
        pkg-config
        rustPlatform
        stdenv
        udev
        ;
    in
    rustPlatform.buildRustPackage (finalAttrs: {
      pname = "asdbctl";
      version = "1.0.0";

      src = fetchFromGitHub {
        owner = "juliuszint";
        repo = "asdbctl";
        rev = "v${finalAttrs.version}";
        hash = "sha256-S5m1iQlchGKc0PODQNDHpNzaNXRepmk5zfK5aXdiMiM=";
      };

      useFetchCargoVendor = true;
      cargoHash = "sha256-OPmnGh6xN6XeREeIgyYB2aeHUpdQ5hFS5MivcTeY29E=";

      nativeBuildInputs = [
        pkg-config
      ];

      buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
        udev
      ];

      postInstall = ''
        install -Dm444 \
          rules.d/20-asd-backlight.rules \
          $out/lib/udev/rules.d/20-asd-backlight.rules
      '';

      meta = {
        description = "Apple Studio Display brightness controll";
        mainProgram = "asdbctl";
        homepage = "https://github.com/juliuszint/asdbctl";
        changelog = "https://github.com/juliuszint/asdbctl/releases/tag/${finalAttrs.version}";
        license = lib.licenses.mit;
        maintainers = [
          lib.maintainers.danieldk
        ];
      };
    });
}

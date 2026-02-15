self: super: {
  mono-lisa = self.stdenvNoCC.mkDerivation {
    name = "mono-lisa";

    src = self.requireFile {
      name = "MonoLisa-Plus-2.017-written-script.zip";
      url = "https://www.monolisa.dev/";
      hash = "sha256-d2EBNWfp4Rh4KTzq92js6SZ4BBMZvbSAJE2vapvuKck=";
    };

    dontConfigure = true;

    nativeBuildInputs = [ self.unzip ];

    installPhase = ''
      mkdir -p $out/share/fonts/opentype
      cp *.ttf $out/share/fonts/opentype/
    '';
  };
}

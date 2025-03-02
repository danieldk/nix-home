self: super: {
  mono-lisa = self.stdenvNoCC.mkDerivation {
    name = "mono-lisa";

    src = self.requireFile {
      name = "MonoLisa-Plus-2.015-written-script.zip";
      url = "https://www.monolisa.dev/";
      hash = "sha256-St/EoPyDshol8zT2JQNKEeXL1VvBnRE7ZzdJOE0ONUE=";
    };

    dontConfigure = true;

    nativeBuildInputs = [ self.unzip ];

    installPhase = ''
      mkdir -p $out/share/fonts/opentype
      cp *.ttf $out/share/fonts/opentype/
    '';
  };
}

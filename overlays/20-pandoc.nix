self: super: {
  # pandoc in nixpkgs has an uncessary large closure:
  #
  # https://github.com/NixOS/nixpkgs/issues/34376
  #
  # So, get a static pandoc build from upstream instead.
  pandoc =
    with super;
    stdenv.mkDerivation rec {
      pname = "pandoc";
      version = "2.7.3";

      src = fetchTarball {
        url = "https://github.com/jgm/pandoc/releases/download/${version}/pandoc-${version}-linux.tar.gz";
        sha256 = "192wxd7519zd6whka6bqbhlgmkzmwszi8fgd39hfr8cz78bc8whc";
      };

      propagatedBuildInputs = [ texlive.combined.scheme-basic ];

      dontBuild = true;

      installPhase = ''
        mkdir -p $out/bin
        cp bin/pandoc $out/bin
      '';
    };
}

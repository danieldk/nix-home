self: super: {
  finalfrontier = with super; rustPlatform.buildRustPackage rec {
  name = "finalfrontier-${version}";
  version = "0.0.1";

  src = fetchGit {
    url = "https://git.danieldk.eu/finalfrontier";
    ref = "docs";
    rev = "16c41bc5edfc11081a1fe6e961b021e428020b52";
  };

  cargoSha256 = "1wpn8x5sdig56h2hia3ic0izwya1yvz5mq89nqjx6vibnj9q4qg1";

  preFixup = ''
    mkdir -p "$out/man/man1"
    cp man/*.1 "$out/man/man1/"
  '';

  meta = with stdenv.lib; {
    description = "Train word embeddings with subword representations";
    license = licenses.apache2;
    platforms = platforms.all;
  };

};

}

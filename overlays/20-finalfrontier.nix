self: super: {
  finalfrontier = with super; rustPlatform.buildRustPackage rec {
  name = "finalfrontier-${version}";
  version = "0.2.0-dev";

  src = fetchFromGitHub {
    owner = "danieldk";
    repo = "finalfrontier";
    rev = "cf9d215f505a760397f4179a997994669864c640";
    sha256 = "1rgl83ia26ll5g9ih2hh9qjh5qc7fsgd3xhm8gi2yjk9gnb3vc29";
    #ref = "tags/v0.1.0";
  };

  cargoSha256 = "1wpn8x5sdig56h2hia3ic0izwya1yvz5mq89nqjx6vibnj9q4qg1";

  nativeBuildInputs = [ gnumake pandoc ];

  postBuild = ''
    ( cd man ; make )
  '';

  preFixup = ''
    mkdir -p "$out/man/man1"
    cp man/*.1 "$out/man/man1/"
    mkdir -p "$out/man/man5"
    cp man/*.5 "$out/man/man5/"
  '';

  meta = with stdenv.lib; {
    description = "Train word embeddings with subword representations";
    license = licenses.asl20;
    platforms = platforms.all;
  };

};

}

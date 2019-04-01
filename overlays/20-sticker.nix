self: super: {
  sticker = with super; rustPlatform.buildRustPackage rec {
  name = "sticker-${version}";
  version = "0.1.0";

  src = fetchgit {
    url = "https://git.sr.ht/~danieldk/sticker";
    rev = "90d00fff4617294825474b1acead803446d243e2";
    sha256 = "0350rnlrwb3yl5wjp4lqqsnd2h2bsiflphahml5gg9mi9n6s692r";
  };

  cargoSha256 = "17pvy8006lkbfpg2cl0fjz0ilq9a309lwni6xl9wz7gydjn8agsy";

  buildInputs = with super ; [ libtensorflow ] ++
    stdenv.lib.optionals stdenv.isDarwin [curl darwin.Security];

  meta = with stdenv.lib; {
    description = "Neural sequence tagger";
    license = licenses.asl20;
    platforms = platforms.all;
  };

};

}

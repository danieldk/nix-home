self: super: {

  conllx-utils = with super; rustPlatform.buildRustPackage rec {
  name = "conllx-utils-${version}";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "danieldk";
    repo = "conllx-utils";
    rev = "${version}";
    sha256 = "1qmrl3ddka9q7awvfxqfyz33ysyv5xf1w2dyswass2q600ny35wz";
  };

  cargoSha256 = "0bswppkshhvylwbip2r1lhr66q4cmhb6l7n8pllmwzz24k0dsn7p";

  meta = with stdenv.lib; {
    description = "CoNLL-X utilities";
    license = licenses.asl20;
    platforms = platforms.all;
  };

};

}

self: super: {

  conllx-utils = with super; rustPlatform.buildRustPackage rec {
  name = "conllx-utils-${version}";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "danieldk";
    repo = "conllx-utils";
    rev = "${version}";
    sha256 = "0yrjpxpz8b11nsnr149yjwdizzfa1hscy18n0cycm2r4nk0nvpsa";
  };

  cargoSha256 = "0bswppkshhvylwbip2r1lhr66q4cmhb6l7n8pllmwzz24k0dsn7p";

  meta = with stdenv.lib; {
    description = "CoNLL-X utilities";
    license = licenses.apache2;
    platforms = platforms.unix;
  };

};

}

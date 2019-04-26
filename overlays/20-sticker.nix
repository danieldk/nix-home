self: super: {
  libtensorflow_113 = with super; let
    system =
      if stdenv.isx86_64 then
        if stdenv.isLinux then "linux-x86_64"
        else if stdenv.isDarwin then "darwin-x86_64"
        else unavailable
      else unavailable;
    unavailable = throw "libtensorflow is not available for this platform!";
  in libtensorflow.overrideAttrs (oldAttrs: rec {
    pname = "libtensorflow";
    name = "${pname}-${version}";
    version = "1.13.1";

    src = fetchurl {
      url = "https://storage.googleapis.com/tensorflow/${pname}/${pname}-cpu-${system}-${version}.tar.gz";
      sha256 =
        if system == "linux-x86_64" then
            "0cfnpqz1s6ilajg0nfirwbp18f3hls2q8bhn6z032jxn90llhk4k"
        else if system == "darwin-x86_64" then
            "0mv0xrnkb871l6j6gpdq84aq5987sabszggl1jyws4hvacipidmq"
        else unavailable;
    };
  });

  sticker = with super; rustPlatform.buildRustPackage rec {
    name = "sticker-${version}";
    version = "0.2.0";

    src = fetchFromGitHub {
        owner = "danieldk";
        repo = "sticker";
        rev = "${version}";
        sha256 = "1b4gsxza6kqaialadh3f2snmgx39db7p315ymk1gad1m10c99gc7";
    };

    cargoSha256 = "0b5x71hrs7qb1sbp1ijb75v2nnrmay4c9a41g0lzwz9qk4q0s51r";

    nativeBuildInputs = [ pkg-config ];

    buildInputs = with super; [ openssl self.libtensorflow_113 ] ++
      stdenv.lib.optional stdenv.isDarwin darwin.Security;

    meta = with stdenv.lib; {
        description = "Neural sequence labeler";
        license = licenses.asl20;
        platforms = platforms.all;
    };
  };
}

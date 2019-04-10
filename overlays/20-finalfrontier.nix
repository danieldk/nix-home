self: super: {
  finalfrontier = with super; rustPlatform.buildRustPackage rec {
  name = "finalfrontier-${version}";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "danieldk";
    repo = "finalfrontier";
    rev = "${version}";
    sha256 = "17sg415471mr335p2m5dj28yhzrivcv2sj6bfvnzbvgnbvgwl203";
  };

  cargoSha256 = "0w6s88kx95f57fn6rr2n8h9q2bhpbz03aip2k5nc5y3g7dfnmcj4";

  nativeBuildInputs = [ gnumake pandoc ];

  buildInputs = with super; stdenv.lib.optional stdenv.isDarwin darwin.Security;

  postBuild = ''
    ( cd man ; make )
  '';

  preFixup = ''
    mkdir -p "$out/man/man1"
    cp man/*.1 "$out/man/man1/"
  '';

  meta = with stdenv.lib; {
    description = "Train word embeddings with subword representations";
    license = licenses.asl20;
    platforms = platforms.all;
  };

};

}

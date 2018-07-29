self: super: {

dact = with super; stdenv.mkDerivation rec {
  name = "dact-${version}";
  version = "2.6.6";

  src = fetchFromGitHub {
    owner = "rug-compling";
    repo = "dact";
    rev = "${version}";
    sha256 = "0p0rrrgm0a55aa65lliirv6d8smhcfm1cd4vyzq03954law3dlcw";
  };

  nativeBuildInputs = [
    unstable.cmake git
  ];

  buildInputs = [
    alpinocorpus boost libxml2 libxslt qt5.qtbase xercesc xqilla zlib
  ];

  meta = with stdenv.lib; {
    description = "Alpino treebank search tool";
    license = licenses.lgpl2_1;
    platforms = platforms.unix;
  };

};

}

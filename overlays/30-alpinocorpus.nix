self: super: {

alpinocorpus = with super; stdenv.mkDerivation rec {
  name = "alpinocorpus-${version}";
  version = "2.8.3";

  src = fetchFromGitHub {
    owner = "rug-compling";
    repo = "alpinocorpus";
    rev = "${version}";
    sha256 = "0xrviphcawxgwfljkvvh162xqca215j53w9xyjgralr2pzslr5cc";
  };

  nativeBuildInputs = [
    cmake pkgconfig
  ];

  buildInputs = [
    boost dbxml libxml2 libxslt xercesc xqilla
  ];

  meta = with stdenv.lib; {
    description = "Library for Alpino treebanks";
    license = licenses.lgpl21;
    platforms = platforms.unix;
  };

};

}

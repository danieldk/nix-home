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
    boost db62 dbxml libiconv libxml2 libxslt xercesc xqilla
  ];

  meta = with stdenv.lib; {
    description = "Library for Alpino treebanks";
    license = licenses.lgpl2_1;
    platforms = platforms.unix;
  };

};

}

self: super: {

alpinocorpus = with super; let
  unstable = import <nixpkgs-unstable> {};
in stdenv.mkDerivation rec {
  name = "alpinocorpus-${version}";
  version = "2.8.1";

  src = fetchFromGitHub {
    owner = "rug-compling";
    repo = "alpinocorpus";
    rev = "2.8.1";
    sha256 = "16wvydlapvghdnynv1kcq16i017r32q4566dvmil8nnkj5h1pwhq";
  };

  patches = [ 
    ./alpinocorpus/no-static-boost.patch
  ];

  nativeBuildInputs = [
    unstable.cmake
  ];

  buildInputs = [
    boost db dbxml libiconv libxml2 libxslt xercesc xqilla
  ];

  meta = with stdenv.lib; {
    description = "Library for Alpino treebanks";
    license = licenses.lgpl2_1;
    platforms = platforms.unix;
  };

};

}

self: super: {

alpinocorpus = with super; let
  unstable = if stdenv.isDarwin then import <nixpkgs-unstable> {} else import <nixos-unstable> {};
in stdenv.mkDerivation rec {
  name = "alpinocorpus-${version}";
  version = "2.8.2";

  src = fetchFromGitHub {
    owner = "rug-compling";
    repo = "alpinocorpus";
    rev = "2.8.2";
    sha256 = "17lfa3104653j0v1kis7jzp70lpdy8l89f6wwlh3mbjw2bi8hj7z";
  };

  nativeBuildInputs = [
    unstable.cmake
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

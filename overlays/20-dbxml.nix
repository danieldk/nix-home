self: super: {

dbxml = with super; stdenv.mkDerivation rec {
  name = "dbxml-${version}";
  version = "6.1.4";

  src = fetchurl {
    url = "http://download.oracle.com/berkeley-db/${name}.tar.gz";
    sha256 = "a8fc8f5e0c3b6e42741fa4dfc3b878c982ff8f5e5f14843f6a7e20d22e64251a";
  };

  patches = [
    ./dbxml/cxx11.patch
    ./dbxml/incorrect-optimization.patch
  ];

  buildInputs = [
    db xercesc xqilla
  ];

  configureFlags = [
    "--with-berkeleydb=${db}"
    "--with-xerces=${xercesc}"
    "--with-xqilla=${xqilla}"
  ];

  preConfigure = ''
    cd dbxml
  '';

  meta = with stdenv.lib; {
    description = "Embeddable XML database";
    license = licenses.agpl3;
    platfomrs = platforms.unix;
  };

};

}

self: super: {

alpino = let
  boost158 = super.boost159.overrideAttrs (oldAttrs: rec {
    name = "boost-${version}";
    version = "1.58.0";

    src = super.fetchurl {
      url = "mirror://sourceforge/boost/boost_1_58_0.tar.bz2";
      sha256 = "1rfkqxns60171q62cppiyzj8pmsbwp1l8jd7p6crriryqd7j1z7x";
    };
  });
  desktopItem = super.makeDesktopItem {
    name = "Alpino";
    exec = "alpino";
    comment = "Alpino dependency parser for Dutch";
    desktopName = "Alpino";
    categories = "Science;Education";
    terminal = "true";
  };
in with super; stdenv.mkDerivation rec {
  name = "Alpino-${version}";
  version = "21310";

  src = fetchurl {
    url = "http://www.let.rug.nl/vannoord/alp/Alpino/versions/binary/Alpino-x86_64-Linux-glibc-2.23-${version}-sicstus.tar.gz";
    sha256 = "0lzgb3k9x3pzy41975fw6c0yrw7l22gp5j3rab679b75dfma5smh";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];
  buildInputs = [
    stdenv.cc.cc.lib
    boost158
    tcl-8_6
    tk-8_6
    xorg.libXScrnSaver
  ];

  dontStrip = true;

  buildPhase = ":";

  installPhase = ''
    # Use system-wide TCL/TK.
    rm -rf create_bin/extralibs

    mkdir -p $out/libexec/alpino
    cp -a * $out/libexec/alpino

    mkdir $out/bin
    makeWrapper $out/libexec/alpino/bin/Alpino $out/bin/alpino

    mkdir -p $out/share/applications
    cp ${desktopItem}/share/applications/* $out/share/applications
  '';

  meta = with stdenv.lib; {
    description = "Alpino dependency parser for Dutch";
    license = licenses.gpl2;
    platforms = [ "x86_64-linux" ];
  };
};

}

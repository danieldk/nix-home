self: super: {

fsa6 = with super; stdenv.mkDerivation rec {
  name = "fsa6-${version}";
  version = "280";

  src = fetchurl {
    url = "http://odur.let.rug.nl/~vannoord/Fsa/binaries/fsa6-${version}-x86_64-linux-glibc2.19.tar.gz";
    sha256 = "1b140b9d31bc1a504893ad17b59893e89e2140ea943e7642e9b4efe616f46093";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];
  buildInputs = [ glibc_2_27 tcl-8_5 tk-8_5 ];

  dontStrip = true;

  buildPhase = ":";

  installPhase = ''
    mkdir -p $out/libexec/fsa6
    cp -a * $out/libexec/fsa6

    mkdir $out/bin
    makeWrapper $out/libexec/fsa6/binary/create/fsa $out/bin/fsa6 --prefix TCLLIBPATH ' ' "${tk-8_5}/lib"

  '';

  meta = with stdenv.lib; {
    description = "Finite state automata utilities";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
};

}

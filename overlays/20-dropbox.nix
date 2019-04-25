self: super: {

  dropbox-filesystem-fix = with super; stdenv.mkDerivation rec {
    name = "dropbox-filesystem-fix-${version}";
    version = "20190417";

    src = fetchFromGitHub {
        owner = "dark";
        repo = "dropbox-filesystem-fix";
        rev = "72f4d04852d5002d9ba29b3f77fbacb2c12d1432";
        sha256 = "03h95lncbw8mss1f67697jl3diiw7iyq6cxqlzgl3xwgxwbhqd0j";
    };

    installPhase = ''
        mkdir -p $out/lib
        cp libdropbox_fs_fix.so $out/lib
    '';

    meta = with stdenv.lib; {
        description = "Fix filesystem detection in Dropbox";
        license = licenses.gpl30;
        platforms = platforms.linux;
    };
  };

  dropbox-filesystem-agnostic = with super; stdenv.mkDerivation rec {
    name = "dropbox-fixed";

    buildInputs = [ makeWrapper ];

    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      makeWrapper ${pkgs.dropbox}/bin/dropbox $out/bin/dropbox \
        --prefix LD_PRELOAD : ${self.dropbox-filesystem-fix}/lib/libdropbox_fs_fix.so
    '';
  };
}

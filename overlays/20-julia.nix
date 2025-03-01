self: super: {

  julia-fhs =
    let
      ldconfigWrapper =
        with super;
        stdenv.mkDerivation {
          name = "ldconfig-env";

          nativeBuildInputs = [ makeWrapper ];

          phases = [
            "installPhase"
            "fixupPhase"
          ];

          installPhase = ''
            makeWrapper ${glibc.bin}/bin/ldconfig $out/sbin/ldconfig \
              --add-flags "-C /usr/ld.so.cache"
          '';
        };
    in
    super.buildFHSUserEnv {
      name = "julia-fhs";

      targetPkgs =
        pkgs: with pkgs; [
          ldconfigWrapper

          julia_11

          autoconf
          binutils
          coreutils
          gnumake
          m4
          pkgconfig
          stdenv.cc
          utillinux

          curl
          git

          cairo
          fontconfig
          freetype
          gettext
          glib.out
          libintl
          libpng
          libffi
          librsvg
          pango.out
          pixman
          zlib
        ];

      extraBuildCommands = with super; ''
        # Cannot write to /etc?
        echo "$out/lib" > $out/usr/ld.so.conf
        ldconfig -f $out/usr/ld.so.conf -C $out/usr/ld.so.cache -v
      '';

      runScript = "julia";
    };
}

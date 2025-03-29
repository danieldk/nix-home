self: super: {

  kopia-ui =
    let
      inherit (self) fetchurl appimageTools;
      pname = "kopia-ui";
      version = "0.19.0";
      src = fetchurl {
        url = "https://github.com/kopia/kopia/releases/download/v${version}/KopiaUI-${version}.AppImage";
        hash = "sha256-ja1a5VoWCqnYtUZUzMSk5pMweguOnXPFvvFRKuMKCKw=";
      };
      appimageContents = appimageTools.extractType2 { inherit pname version src; };
    in
    appimageTools.wrapType2 {
      inherit pname version src;

      extraInstallCommands = ''
        install -Dm444 \
          ${appimageContents}/kopia-ui.desktop \
          -t $out/share/applications
        substituteInPlace $out/share/applications/kopia-ui.desktop \
          --replace-fail "AppRun --no-sandbox %U" "kopia-ui"
        cp -r ${appimageContents}/usr/share/icons $out/share
      '';
    };

}

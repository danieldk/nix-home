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
    in
    appimageTools.wrapType2 {
      inherit pname version src;
    };

}

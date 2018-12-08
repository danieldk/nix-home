self: super: {

# Source: https://github.com/jwiegley/nix-config
installApplication = 
  { name, appname ? name, version, src, description, homepage, 
    postInstall ? "", sourceRoot ? ".", ... }:
  with super; stdenv.mkDerivation {
    name = "${name}-${version}";
    version = "${version}";
    src = src;
    buildInputs = [ undmg unzip ];
    sourceRoot = sourceRoot;
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      mkdir -p "$out/Applications/${appname}.app"
      cp -pR * "$out/Applications/${appname}.app"
    '' + postInstall;
    meta = with stdenv.lib; {
      description = description;
      homepage = homepage;
      maintainers = with maintainers; [ jwiegley ];
      platforms = platforms.darwin;
    };
  };

  Dash = self.installApplication rec {
    name = "Dash";
    version = "4.5.3";
    sourceRoot = "Dash.app";
    src = super.fetchurl {
      url = https://kapeli.com/downloads/v4/Dash.zip;
      sha256 = "0z8365shmwn26c2fcwv18drmi1i06myj1wspc563kaic7g7z9l4v";
    };
   description = "Dash is an API Documentation Browser and Code Snippet Manager";
    homepage = https://kapeli.com/dash;
  };

  iTerm2 = self.installApplication rec {
    name = "iTerm2";
    appname = "iTerm";
    version = "3.2.6";
    sourceRoot = "iTerm.app";
    src = super.fetchurl {
      url = "https://iterm2.com/downloads/stable/iTerm2-3_2_6.zip";
      sha256 = "116qmdcbbga8hr9q9n1yqnhrmmq26l7pb5lgvlgp976yqa043i6v";
    };
    description = "iTerm2 is a replacement for Terminal and the successor to iTerm";
    homepage = https://www.iterm2.com;
  };

  LaunchBar = self.installApplication rec {
    name = "LaunchBar";
    version = "6.9.5";
    sourceRoot = "LaunchBar.app";
    src = super.fetchurl {
      url = "https://www.obdev.at/downloads/launchbar/LaunchBar-${version}.dmg";
      sha256 = "0ldmbbh0snsdsfgbqsxwp954622am5nf5iqyx9n536wz9yfhyvw3";
    };
    description = ''
      Start with a single keyboard shortcut to access and control every aspect
      of your digital life.
    '';
    homepage = https://www.obdev.at/products/launchbar;
  };

  TableFlip = self.installApplication rec {
    name = "TableFlip";
    version = "1.1.8";
    sourceRoot = "TableFlip.app";
    src = super.fetchurl {
    url = "https://s3.amazonaws.com/tableflip/TableFlip-v${version}.zip";
      sha256 = "0e1e735c90c36ea7e595a915ad974975879785dc79383e0386f866ceb67a5bef";
    };
    description = ''
      TableFlip is a visual Markdown table editor.
    '';
    homepage = https://tableflipapp.com/;
  };
}

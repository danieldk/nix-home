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
    version = "4.2.0";
    sourceRoot = "Dash.app";
    src = super.fetchurl {
      url = https://kapeli.com/downloads/v4/Dash.zip;
      sha256 = "fcd9f71c45fa53b77a57134d342ed186b7d65ca88f434361c560ea964f04ecbd";
    };
   description = "Dash is an API Documentation Browser and Code Snippet Manager";
    homepage = https://kapeli.com/dash;
  };

  iTerm2 = self.installApplication rec {
    name = "iTerm2";
    appname = "iTerm";
    version = "3.1.7";
    sourceRoot = "iTerm.app";
    src = super.fetchurl {
      url = "https://iterm2.com/downloads/stable/iTerm2-3_1_7.zip";
      sha256 = "d5496b3c42fe2eaf65befef7d6d6682cde3e8cd1f042f63343f821e8582b1ede";
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
}

self: super: {
  rustracer =
  let
    mozillaOverlay = super.fetchFromGitHub {
      owner = "mozilla";
      repo = "nixpkgs-mozilla";
      rev = "9f35c4b09fd44a77227e79ff0c1b4b6a69dff533";
      sha256 = "18h0nvh55b5an4gmlgfbvwbyqj91bklf1zymis6lbdh75571qaz0";
    };
    mozilla = super.callPackage "${mozillaOverlay.out}/package-set.nix" { };
    rustNightly = (mozilla.rustChannelOf { date = "2019-07-07"; channel = "nightly"; }).rust;
    rustPlatform = super.makeRustPlatform {
      cargo = rustNightly;
      rustc = rustNightly;
    };
  in rustPlatform.buildRustPackage rec {
    pname = "racer";
    version = "2.1.23";

    src = super.fetchFromGitHub {
      owner = "racer-rust";
      repo = "racer";
      rev = "v${version}";
      sha256 = "16b2gbfv26y40gr0h6gf0d0cq7axd3h8ik2migvdy8zb7d2pjqrz";
    };

    patches = with super; [
      (substituteAll {
        src = ./racer/rust-src.patch;
        inherit (super.rustPlatform) rustcSrc;
      })
    ];

    cargoSha256 = "0wn831jlkbh1x1mndifrs7w1hrqp4lhz3ak8hp6rq5irfavkgd5n";

    buildInputs = with super; [ makeWrapper ];

    preCheck = ''
      export RUST_SRC_PATH="${super.rustPlatform.rustcSrc}"
    '';

    preConfigure = ''
      export HOME=`mktemp -d`
    '';

    doCheck = false;

    meta = with super.stdenv.lib; {
      description = "A utility intended to provide Rust code completion for editors and IDEs";
      homepage = https://github.com/racer-rust/racer;
      license = licenses.mit;
      maintainers = with maintainers; [ danieldk ];
      platforms = platforms.all;
    };
  };
}

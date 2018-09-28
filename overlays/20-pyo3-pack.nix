self: super: {
  pyo3-pack = let
    inherit (self.darwin.apple_sdk.frameworks) Security;
  in with self; self.rustPlatform.buildRustPackage rec {
    name = "pyo3-pack-${version}";
    version = "0.3.1";
  
    src = fetchFromGitHub {
      owner = "PyO3";
      repo = "pyo3-pack";
      rev = "v${version}";
      sha256 = "1fal6klkyfzm0qdwjc578a3hp3li24401ffs5yjz42d17jb8kx9r";
    };
  
    cargoSha256 = "0lmg30bypzqczyqa7k1633dxbljyr14a2rp83wjbfqhwb32hm9m5";
  
    cargoPatches = [ ./pyo3-pack/Cargo.lock.diff ];
  
    nativeBuildInputs = [ pkgconfig ];
  
    buildInputs = [ gmp openssl ]
      ++ stdenv.lib.optional stdenv.isDarwin Security
      ++ stdenv.lib.optional stdenv.isLinux dbus;
  
    # Requires network access, fails in sandbox.
    doCheck = false;
  
    meta = with stdenv.lib; {
      description = "Build and publish crates with pyo3 bindings as python packages";
      homepage = https://github.com/PyO3/pyo3-pack;
      license = licenses.mit;
      maintainers = [ maintainers.danieldk ];
      platforms = platforms.all;
    };
  };
}

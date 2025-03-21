self: super: {
  asdbctl = self.rustPlatform.buildRustPackage {
    pname = "asdbctl";
    version = "1.0.0";

    src = self.fetchFromGitHub {
      owner = "juliuszint";
      repo = "asdbctl";
      rev = "v${version}";
      hash = "";
    };
  };
}

self: super: {

  jupyterEnv =
    let unstable = import (if self.stdenv.isDarwin then <nixpkgs-unstable> else <nixos-unstable>) {};
  skl = unstable.python36Packages.scikitlearn.overridePythonAttrs (oldAttrs: { checkPhase = ""; });
  in self.myEnvFun {
    name = "jupyter36";

    buildInputs = with unstable.python36Packages; [
      matplotlib
      notebook
      numpy
      skl
      scipy
      tensorflowWithoutCuda
    ];
  };
}

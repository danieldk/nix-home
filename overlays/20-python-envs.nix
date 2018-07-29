self: super: {

  jupyterEnv = with super;
    let skl = python36Packages.scikitlearn.overridePythonAttrs (oldAttrs: { checkPhase = ""; });
  in self.myEnvFun {
    name = "jupyter36";

    buildInputs = with python36Packages; [
      matplotlib
      notebook
      numpy
      skl
      scipy
      tensorflowWithoutCuda
    ];
  };
}

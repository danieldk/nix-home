self: super: {

  jupyterEnv = with super; self.myEnvFun {
    name = "jupyter36";

    buildInputs = with python36Packages; [
      matplotlib
      notebook
      numpy
      scikitlearn
      scipy
      tensorflowWithoutCuda
    ];
  };
}

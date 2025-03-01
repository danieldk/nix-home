self: super: {

  jupyterEnv =
    with super;
    self.myEnvFun {
      name = "jupyter36";

      buildInputs = with python36Packages; [
        gensim
        numpy
        scikitlearn
        scipy
        tensorflowWithoutCuda

        ipywidgets
        notebook
        matplotlib
      ];
    };
}

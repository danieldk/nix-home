self: super: {

jupyterEnv = with super; let
  unstable = import <nixpkgs-unstable> {};
  skl = unstable.python36.pkgs.scikitlearn.overridePythonAttrs (oldAttrs: { checkPhase = ""; });
in unstable.python36.withPackages (ps: with ps; [
  matplotlib
  notebook
  numpy
  skl
  scipy
  tensorflowWithoutCuda
]);

}

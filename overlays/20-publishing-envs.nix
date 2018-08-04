self: super: let
  fontConfigFile = with self; makeFontsConf {
    fontDirectories = [
      lato source-code-pro
    ];
  };
in {
  latexEnv = self.myEnvFun {
    name = "latex";

    buildInputs = with self; [
      texlive.combined.scheme-full
    ];

    extraCmds = ''
      export FONTCONFIG_FILE=${fontConfigFile}
    '';
  };

  pandocEnv = self.myEnvFun {
    name = "pandoc";

    buildInputs = with self; [
      fontconfig
      pandoc
      haskellPackages.pandoc-citeproc
      texlive.combined.scheme-full
    ];

    extraCmds = ''
      export FONTCONFIG_FILE=${fontConfigFile}
    '';
  };
}

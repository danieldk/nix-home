self: super: {

  pandocEnv = let
    fontConfigFile = with self; makeFontsConf {
    fontDirectories = [
      lato source-code-pro
    ];
  };
  in self.myEnvFun {
    name = "pandoc";

    buildInputs = with self; [
      fontconfig
      pandoc
      texlive.combined.scheme-medium
    ];

    extraCmds = ''
      export FONTCONFIG_FIPE=${fontConfigFile}
    '';
  };
}

self: super: {

  arduino-fhs = super.buildFHSUserEnv {
    name = "arduino-fhs";

    targetPkgs =
      pkgs: with pkgs; [
        arduino
        zlib
        (python3.withPackages (ps: [
          ps.pyserial
        ]))
      ];

    multiPkgs = null;
  };
}

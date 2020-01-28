self: super: {
  nixops-19_03 = with super; let
    wrapper = writeShellScriptBin "nixops-19_03" ''
      export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.03.tar.gz
      echo "NIX_PATH=$NIX_PATH"
      ${nixops}/bin/nixops $@
    '';
  in stdenv.mkDerivation rec {
    name = "nixops-pinned";

    buildInputs = [ wrapper ];

    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      cp ${wrapper}/bin/nixops-19_03 $out/bin
    '';
  };
}

{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initExtra = ''
      nixify() {
        if [ ! -e ./.envrc ]; then
          echo "use nix" > .envrc
          ${pkgs.direnv}/bin/direnv allow
        fi
        if [ ! -e default.nix ]; then
            cat > default.nix <<'EOF'
      with import <nixpkgs> {};
      stdenv.mkDerivation {
      name = "env";
      buildInputs = [
          bashInteractive
      ];
      }
      EOF
          ''${EDITOR:-vim} default.nix
        fi
      }
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "pass" "vi-mode" "z" ];
      theme = "agnoster";
    };
  };
}

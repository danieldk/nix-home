{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history.expireDuplicatesFirst = true;

    initExtra = ''
      # vi-style input
      bindkey -v
      export KEYTIMEOUT=1

      bindkey '^R' history-incremental-pattern-search-backward

      export PS1='%F{green}%~%f %# '

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

    plugins = [
      {
        name = "z";
        file = "z.sh";
        src = pkgs.fetchFromGitHub {
          owner = "rupa";
          repo = "z";
          rev = "v1.9";
          sha256 = "1h0yk0sbv9d571sfkg97wi5q06cpxnhnvh745dlpazpgqi1vb1a8";
        };
      }
    ];
  };
}

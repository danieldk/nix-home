{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      save = 100000;
      size = 100000;
    };

    defaultKeymap = "viins";

    localVariables = {
      KEYTIMEOUT = 1;
      PS1="%F{green}%~%f %# ";
      RPS1="";
    };

    initExtra = ''
      bindkey '^R' history-incremental-pattern-search-backward

      nixify() {
        if [ ! -e ./.envrc ]; then
          echo "use nix -s shell.nix" > .envrc
          ${pkgs.direnv}/bin/direnv allow
        fi
        if [ ! -e shell.nix ]; then
            cat > shell.nix <<'EOF'
      with import <nixpkgs> {};
      stdenv.mkDerivation {
      name = "env";
      buildInputs = [
          bashInteractive
      ];
      }
      EOF
          ''${EDITOR:-vim} shell.nix
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
      {
        name = "fzf-tab";
        file = "fzf-tab.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "17ff089938a8f693689d67814af3212fc4053da1";
          sha256 = "1cizy2nlmvrblirxkl7036fnp1q55s11v5pxm7x64jx1591iy67s";
        };
      }
    ];
  };
}

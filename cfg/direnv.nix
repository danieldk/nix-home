{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".direnvrc".text = ''
      use_nix() {
        nixpkgs_ver=$(nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version' | tr -d '"')
        local cache=".direnv.$nixpkgs_ver"
        if [[ ! -e "$cache" ]] || \
           [[ "$HOME/.direnvrc" -nt "$cache" ]] || \
           [[ ".envrc" -nt "$cache" ]] || \
           [[ "default.nix" -nt "$cache" ]] || \
           [[ "shell.nix" -nt "$cache" ]];
        then
          local tmp="$(mktemp "''${cache}.tmp-XXXXXXXX")"
          trap "rm -rf '$tmp'" EXIT
          nix-shell --show-trace "$@" --run 'direnv dump' > "$tmp" && \
            mv "$tmp" "$cache"
        fi
        direnv_load cat "$cache"
        if [[ $# = 0 ]]; then
          watch_file default.nix
          watch_file shell.nix
        fi
      }
    '';
  };
}

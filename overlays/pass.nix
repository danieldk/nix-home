final: prev: 
let
  inherit (final) fzf getExe passage writeScriptBin;
in {
  pass-find = writeScriptBin "pass-find" ''
    set -eou pipefail
    PREFIX="${PASSAGE_DIR:-$HOME/.passage/store}"
    FZF_DEFAULT_OPTS=""
    name="$(find "$PREFIX" -type f -name '*.age' | \
      sed -e "s|$PREFIX/||" -e 's|\.age$||' | \
      ${getExe fzf} --height 40% --reverse --no-multi)"
    ${getExe passage} "${@}" "$name"
  '';
}

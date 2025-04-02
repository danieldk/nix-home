final: prev:
let
  inherit (final) fzf passage writeScriptBin;
  inherit (final.lib) getExe;
in
{
  pass-find = writeScriptBin "pass-find" ''
    set -eou pipefail
    PREFIX="''${PASSAGE_DIR:-$HOME/.passage/store}"
    FZF_DEFAULT_OPTS=""
    name="$(find "$PREFIX" -type f -name '*.age' | \
      sed -e "s|$PREFIX/||" -e 's|\.age$||' | \
      ${getExe fzf} --height 40% --reverse --no-multi)"
    ${getExe passage} "''${@}" -c "$name"
  '';

  pass-find-desktop = prev.makeDesktopItem {
    name = "pass-find";
    desktopName = "pass-find";
    icon = "org.gnome.seahorse.Application";
    exec = "${getExe final.pass-find}";
    terminal = true;
  };
}

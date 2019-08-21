self: super: rec {
  pass-find = with self; writeScriptBin "pass-find" ''
    #! ${bash}/bin/sh

    shopt -s nullglob globstar

    prefix="''${PASSWORD_STORE_DIR:-$HOME/.password-store}"

    # From passmenu
    password_files=( "$prefix"/**/*.gpg )
    password_files=( "''${password_files[@]#"$prefix"/}" )
    password_files=( "''${password_files[@]%.gpg}" )

    ACCOUNT=$(printf '%s\n' "''${password_files[@]}" | fzf)

    [[ -n ''${ACCOUNT} ]] || exit

    if [ $? -eq 0 ]; then
      nohup pass -c "''${ACCOUNT}" >/dev/null 2>&1
    fi
  '';
  pass-find-desktop = super.makeDesktopItem {
    name = "pass-find";
    desktopName = "pass-find";
    exec = "${pass-find}/bin/pass-find";
    terminal = "true";
  };
}

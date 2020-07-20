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
  wrapit = with self; writeScriptBin "wrapit" ''
    #!${bash}/bin/sh
    ${bubblewrap}/bin/bwrap \
      --ro-bind /nix /nix \
      --dir /tmp \
      --dir /var \
      --dir /home/$(id -u) \
      --symlink /tmp /var/tmp \
      --proc /proc \
      --dev /dev \
      --ro-bind /etc/resolv.conf /etc/resolv.conf \
      --unshare-all \
      --die-with-parent \
      --dir /run/user/$(id -u) \
      --setenv XDG_RUNTIME_DIR "/run/user/$(id -un)" \
      "$@"
  '';

}

self: super: {
  # Remove when https://github.com/NixOS/nixpkgs/pull/388905
  # is merged.
  libfprint-tod = super.libfprint-tod.overrideAttrs (prevAttrs: rec {
    version = "1.94.9+tod1";
    name = "${prevAttrs.pname}-${version}";
    src = self.fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "3v1n0";
      repo = "libfprint";
      rev = "v${version}";
      hash = "sha256-xkywuFbt8EFJOlIsSN2hhZfMUhywdgJ/uT17uiO3YV4=";
    };
    mesonFlags = prevAttrs.mesonFlags ++ [
      "-Dudev_rules_dir=${placeholder "out"}/lib/udev/rules.d"
    ];
    postPatch = prevAttrs.postPatch + ''
      patchShebangs ./libfprint/tod/tests/*.sh
    '';
  });
}

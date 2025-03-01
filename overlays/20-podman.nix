self: super: {
  podman-fhs =
    let
      registriesConf = super.writeText "registries.conf" ''
        [registries.search]
        registries = ['docker.io']

        [registries.block]
        registries = []
      '';
      etcFiles = super.runCommandNoCC "setup-etc" { } ''
        mkdir -p $out/etc/containers 
        ln -s ${super.skopeo.src}/default-policy.json \
          $out/etc/containers/policy.json
        ln -s ${registriesConf} $out/etc/containers/registries.conf

        ln -s /host/etc/subuid $out/etc/subuid
        ln -s /host/etc/subgid $out/etc/subgid
      '';
    in
    super.buildFHSUserEnv {
      name = "podman";

      targetPkgs =
        pkgs: with pkgs; [
          conmon
          etcFiles
          fuse-overlayfs
          podman
          runc
          skopeo
          slirp4netns
        ];

      runScript = "${super.podman}/bin/podman";
    };
}

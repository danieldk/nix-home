{ pkgs, ... }:
{
  home.packages =
    let
      wrapper =
        with pkgs;
        writeShellScriptBin "podman" ''
          ${podman}/bin/podman \
          --storage-driver=overlay \
          --storage-opt="overlay.mount_program=${fuse-overlayfs}/bin/fuse-overlayfs" \
            $@
        '';
    in
    with pkgs;
    [ wrapper ];

  xdg.configFile = with pkgs; {
    "containers/libpod.conf".text = ''
      runtime_path= ["${runc}/bin/runc"]
      conmon_path= ["${conmon}/bin/conmon"]
      cni_plugin_dir = ["${cni-plugins}/bin/"]
      network_cmd_path = "${slirp4netns}/bin/slirp4netns"
      cgroup_manager = "systemd"
      cni_config_dir = "/etc/cni/net.d/"
      cni_default_network = "podman"
      # pause
      pause_image = "k8s.gcr.io/pause:3.1"
      pause_command = "/pause"
    '';
    "containers/registries.conf".text = ''
      [registries.search]
      registries = ['docker.io']
    '';
    "containers/policy.json".text = ''
      {
        "default": [
          { "type": "insecureAcceptAnything" }
        ]
      }
    '';
  };
}

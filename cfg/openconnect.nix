{ pkgs, ... }:

let
  vpncScript = pkgs.writeScript "uniTueVpnc" ''
    # Cisco-provided route only covers a subset of the university
    # network. Fixup.
    export INTERNAL_IP4_NETADDR="134.2.0.0"
    export INTERNAL_IP4_NETMASK="255.255.0.0"
    export INTERNAL_IP4_NETMASKLEN="16"

    exec ${pkgs.vpnc}/etc/vpnc/vpnc-script
  '';
  vpnScript = pkgs.writeScriptBin "vpn" ''
    #! ${pkgs.bash}/bin/sh
    pass Work/UniTuebingen | \
    sudo ${pkgs.openconnect}/bin/openconnect --passwd-on-stdin -u nnsdd01 --no-dtls \
    --script ${vpncScript} ras.uni-tuebingen.de
  '';
  vpnDesktopItem = pkgs.makeDesktopItem {
    name = "uni-tuebingen-vpn";
    desktopName = "University of Tübingen VPN";
    exec = "${vpnScript}/bin/vpn";
    terminal = "true";
  };
in {
  home.packages = [ vpnDesktopItem vpnScript ];
}

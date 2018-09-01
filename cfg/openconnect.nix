{ pkgs, ... }:

{
  home.packages = with pkgs; [
    openconnect
  ];

  programs.zsh.shellAliases = let
    vpncScript = with pkgs; pkgs.writeScript "uniTueVpnc" ''
      # Cisco-provided route only covers a subset of the university
      # network. Fixup.
      export INTERNAL_IP4_NETADDR="134.2.0.0"
      export INTERNAL_IP4_NETMASK="255.255.0.0"
      export INTERNAL_IP4_NETMASKLEN="16"

      exec ${vpnc}/etc/vpnc/vpnc-script
    '';
  in {
  vpn = builtins.replaceStrings ["\n"] [" "] ''
    pass Work/UniTuebingen |
    sudo openconnect --passwd-on-stdin -u nnsdd01 --no-dtls
      --script ${vpncScript} ras.uni-tuebingen.de
    '';
  };
}

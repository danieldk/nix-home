{ pkgs, ... }:

{
  home.packages = with pkgs; [
    openconnect
  ];

  programs.zsh.shellAliases = {
    vpn = "pass Work/UniTuebingen  | sudo openconnect --passwd-on-stdin -u nnsdd01 --no-dtls ras.uni-tuebingen.de";
  };
}

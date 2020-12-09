{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dogdns
    mosh
    rsync
    sshuttle
  ];

  programs.ssh = {
    enable = true;
  };
}

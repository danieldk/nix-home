{ pkgs, ... }:

{
  home.packages = with pkgs; [
    doggo
    mosh
    rsync
    sshuttle
  ];

  programs.ssh = {
    enable = true;
  };
}

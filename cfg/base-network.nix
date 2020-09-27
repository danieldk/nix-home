{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mosh
    rsync
    sshuttle
  ];
}

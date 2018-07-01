{ pkgs, ... }:

{
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Daniël de Kok";
    userEmail = "me@danieldk.eu";
  };
}

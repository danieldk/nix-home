{ pkgs, ... }:

{
  programs.git = {
    package = pkgs.gitFull;
    enable = true;
    settings = {
      github.user = "danieldk";
      user = {
        email = "me@danieldk.eu";
        name = "Daniël de Kok";
      };
    };
    lfs.enable = true;
  };

  home.packages = with pkgs; [
    git-crypt
  ];
}

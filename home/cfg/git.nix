{ pkgs, ... }:

{
  programs.git = {
    package = pkgs.gitFull;
    enable = true;
    userName = "Daniël de Kok";
    userEmail = "me@danieldk.eu";
    lfs.enable = true;
  };

  programs.git.extraConfig = {
    github = {
      user = "danieldk";
    };

    "protocol \"keybase\"" = {
      allow = "always";
    };
  };

  home.packages = with pkgs; [
    git-crypt
  ];
}

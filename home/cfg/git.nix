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
      "lfs \"customtransfer.xet\"" = {
         path = "${pkgs.git-xet}/bin/git-xet";
         args = "transfer";
         concurrent = true;
      };
    };
    lfs.enable = true;
  };

  home.packages = with pkgs; [
    git-crypt
    git-xet
  ];
}

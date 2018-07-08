{ pkgs, ... }:

{
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Daniël de Kok";
    userEmail = "me@danieldk.eu";
  };

  programs.git.extraConfig = {
    "filter \"lfs\"" = {
      clean = "${pkgs.git-lfs}/bin/git-lfs clean -- %f";
      smudge = "${pkgs.git-lfs}/bin/git-lfs smudge --skip -- %f";
      process = "${pkgs.git-lfs}/bin/git-lfs filter-process";
      required = true;
    };
  };

  home.packages = with pkgs; [
    git-lfs
  ];
}

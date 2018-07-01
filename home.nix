{ pkgs, ... }:

{
  home.packages = [
    pkgs.gcc
    pkgs.gdb
    pkgs.gnupg
    pkgs.htop
    pkgs.ncdu
    pkgs.pass
    pkgs.ripgrep
    pkgs.skypeforlinux
    pkgs.spotify
    pkgs.tdesktop
    pkgs.unstable.makemkv
    pkgs.youtube-dl
  ];

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.evil
      epkgs.magit
      epkgs.nix-mode
    ];
  };

  programs.firefox = {
    enable = true;
  };

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Daniël de Kok";
    userEmail = "me@danieldk.eu";
  };

  programs.zsh.enable = true;

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "pass" ];
    theme = "agnoster";
  };

  programs.vim = {
    enable = true;
    settings = {
      relativenumber = true;
      number = true;
    };
  };
}

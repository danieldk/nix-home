{ pkgs, ... }:

{
  imports = [
    ./cfg/git.nix
    ./cfg/fzf.nix
    ./cfg/vim.nix
    ./cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    gcc
    gdb
    gnupg
    htop
    mpv
    ncdu
    pass
    ripgrep
    skypeforlinux
    spotify
    tdesktop
    unstable.makemkv
    youtube-dl
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
}

{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  imports = [
    ../cfg/dropbox.nix
    ../cfg/git.nix
    ../cfg/fzf.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
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
    rustChannels.stable.rust
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

{ pkgs, ... }:

{
  imports = [
    ../cfg/base-unix.nix
    ../cfg/base-network.nix
    ../cfg/direnv.nix
    ../cfg/emacs.nix
    ../cfg/fish.nix
    ../cfg/git.nix
    ../cfg/fzf.nix
    ../cfg/kitty.nix
    ../cfg/mail.nix
    ../cfg/mupdf.nix
    ../cfg/openconnect.nix
    ../cfg/podman.nix
    ../cfg/publishing.nix
    ../cfg/resilio.nix
    ../cfg/restic.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    danieldk.alpinocorpus
    danieldk.dact

    binutils
    brave
    drawio
    firefox-bin
    gdb
    gitAndTools.hub
    gnome-mpv
    handbrake
    html2text
    mpv
    niv
    nix-bundle
    nixops
    nixops-19_03
    pass-find-desktop
    signal-desktop
    skypeforlinux
    spotify
    tdesktop
    makemkv
  ];


  home.sessionVariables = {
    NIX_PATH = "$HOME/git/nixpkgs:nixpkgs=$HOME/git/nixpkgs:nixpkgs-unstable=$HOME/git/nixpkgs";
  };
  #programs.firefox = {
  #  enable = true;
  #  package = pkgs.firefox-bin;
  #};

  home.file = {
    ".config/autostart/gnome-keyring-ssh.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=SSH Key Agent
      Hidden=true
    '';
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      PKCS11Provider ${pkgs.opensc}/lib/opensc-pkcs11.so
    '';
  };

  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry_gnome}/bin/pinentry-gnome3
    '';
  };
}

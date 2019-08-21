{ pkgs, ... }:

{
  imports = [
    ../cfg/base-unix.nix
    ../cfg/base-network.nix
    ../cfg/direnv.nix
    ../cfg/emacs.nix
    ../cfg/git.nix
    ../cfg/fzf.nix
    ../cfg/kitty.nix
    ../cfg/mail.nix
    ../cfg/mupdf.nix
    ../cfg/openconnect.nix
    ../cfg/podman.nix
    ../cfg/resilio.nix
    ../cfg/restic.nix
    ../cfg/publishing.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    danieldk.alpinocorpus
    danieldk.dact

    binutils
    bubblewrap
    dbxml
    fsa6
    gcc
    gdb
    gnome-mpv
    google-chrome
    html2text
    jupyterEnv
    mpv
    nixops-pinned
    pass-find-desktop
    skypeforlinux
    spotify
    tdesktop
    makemkv
    qutebrowser

    proprietary-fonts

    #pyo3-pack
  ];

  programs.firefox = {
    enable = true;
  };

  home.sessionVariables = {
    NIX_PATH = "$HOME/git/nixpkgs:nixpkgs=$HOME/git/nixpkgs:nixpkgs-unstable=$HOME/git/nixpkgs";
  };

  home.file = {
    ".config/autostart/gnome-keyring-ssh.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=SSH Key Agent
      Hidden=true
    '';

    ".local/share/applications/pass-find.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=pass-find
      Exec=${pkgs.pass-find}/bin/pass-find
      Terminal=true
    '';
  };
}

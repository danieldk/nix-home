{ pkgs, ... }:

{
  imports = [
    ../cfg/base-unix.nix
    ../cfg/dropbox.nix
    ../cfg/emacs.nix
    ../cfg/git.nix
    ../cfg/fzf.nix
    ../cfg/mail.nix
    ../cfg/mupdf.nix
    ../cfg/openconnect.nix
    ../cfg/restic.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    binutils
    bubblewrap
    corebird
    dbxml
    gnome3.dconf
    gnome3.defaultIconTheme
    fsa6
    gcc
    gdb
    google-chrome
    html2text
    jupyterEnv
    keybase
    keybase-gui
    mpv
    nixops-pinned
    pandocEnv
    skypeforlinux
    spotify
    tdesktop
    makemkv
  ];

  programs.firefox = {
    enable = true;
  };

  home.sessionVariables = {
    NIX_PATH = "$HOME/git/nixpkgs:nixpkgs=$HOME/git/nixpkgs:nixpkgs-unstable=$HOME/git/nixpkgs";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };

  home.file = {
    ".config/autostart/gnome-keyring-ssh.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=SSH Key Agent
      Hidden=true
    '';

    ".local/share/applications/passmenu.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=passmenu
      Exec=${pkgs.pass}/bin/passmenu -i -b
      Terminal=false
    '';
  };

  services.keybase.enable = true;
  services.kbfs.enable = true;
}

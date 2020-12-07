{ pkgs, ... }:

{
  imports = [
    ../modules/emacs-init.nix

    ../cfg/base-unix.nix
    ../cfg/base-network.nix
    ../cfg/desktop.nix
    ../cfg/direnv.nix
    ../cfg/emacs.nix
    ../cfg/git.nix
    ../cfg/go.nix
    ../cfg/fzf.nix
    ../cfg/kitty.nix
    ../cfg/mail.nix
    #../cfg/podman.nix
    ../cfg/latex.nix
    ../cfg/resilio.nix
    ../cfg/restic.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    alpinocorpus
    conllu-utils

    _1password-gui
    binutils
    brave
    crate2nix
    dogdns
    drawio
    #(wrapFirefox mozilla.latest.firefox-bin.unwrapped {
    #  forceWayland = true;
    #  browserName = "firefox";
    #  pname = "firefox-bin-wayland"; })
    #firefox-wayland
    firefox
    gdb
    gnome-mpv
    google-chrome
    handbrake
    html2text
    morph
    niv
    nix-bundle
    nix-review
    pass-find-desktop
    #podman-fhs
    signal-desktop
    skypeforlinux
    spotify
    steam
    tdesktop
    makemkv
    wrapit
  ] ++ (with gitAndTools; [
    gh
  ]) ++ (with jetbrains; [
    clion
    idea-ultimate
    pycharm-professional
  ]);

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

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  programs.mpv = {
    enable = true;
    config = {
      hwdec = "nvdec";
      vo = "gpu";
    };
  };

  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry_gnome}/bin/pinentry-gnome3
    '';
  };
}

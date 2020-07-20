{ pkgs, ... }:

{
  imports = [
    ../modules/emacs-init.nix

    ../cfg/base-unix.nix
    ../cfg/base-network.nix
    ../cfg/direnv.nix
    ../cfg/emacs.nix
    ../cfg/git.nix
    ../cfg/go.nix
    ../cfg/fzf.nix
    ../cfg/kitty.nix
    ../cfg/mail.nix
    #../cfg/podman.nix
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
    crate2nix
    drawio
    (wrapFirefox mozilla.latest.firefox-bin.unwrapped {
      forceWayland = true;
      browserName = "firefox";
      pname = "firefox-bin-wayland"; })
    gdb
    gitAndTools.hub
    gnome-mpv
    handbrake
    html2text
    morph
    mpv
    niv
    nix-bundle
    pass-find-desktop
    podman-fhs
    ripcord
    signal-desktop
    skypeforlinux
    spotify
    tdesktop
    makemkv
  ];

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

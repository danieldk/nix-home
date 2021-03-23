{ pkgs, ... }:

{
  imports = [
    ../modules/emacs-init.nix

    ../cfg/base-unix.nix
    ../cfg/base-desktop.nix
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
    crate2nix
    drawio
    #(wrapFirefox mozilla.latest.firefox-bin.unwrapped {
    #  forceWayland = true;
    #  browserName = "firefox";
    #  pname = "firefox-bin-wayland"; })
    #firefox-wayland
    handbrake
    html2text
    morph
    nix-bundle
    nix-review
    #podman-fhs
    steam
    makemkv
    wrapit
  ] ++ (with jetbrains; [
    clion
    idea-ultimate
    pycharm-professional
  ]);
}

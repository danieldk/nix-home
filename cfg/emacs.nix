{ pkgs, ... }:

let
  unstable = with pkgs.stdenv;
  if isDarwin then import <nixpkgs-unstable> {}
  else import <nixos-unstable> {};
in {
  programs.emacs = {
    enable = true;
    package = unstable.emacs;
    extraPackages = epkgs: [
      epkgs.company
      epkgs.counsel
      epkgs.diminish
      epkgs.evil
      epkgs.evil-magit
      epkgs.evil-mu4e
      epkgs.flycheck
      epkgs.general
      epkgs.ivy
      epkgs.leuven-theme
      epkgs.magit
      epkgs.nix-mode
      epkgs.projectile
      epkgs.swiper
      epkgs.use-package
      epkgs.which-key

      # Rust
      epkgs.cargo
      epkgs.flycheck-rust
      epkgs.racer
      epkgs.rust-mode
    ];
  };

  home.file = {
    ".emacs".text = builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/dev;
    ".emacs-mu4e".text = builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/mu4e;
  };

  programs.zsh.shellAliases = {
    mue = "emacs -q --load ~/.emacs-mu4e";
  };
}

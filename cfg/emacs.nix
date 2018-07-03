{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.company
      epkgs.counsel
      epkgs.diminish
      epkgs.evil
      epkgs.evil-magit
      epkgs.flycheck
      epkgs.general
      epkgs.ivy
      epkgs.magit
      epkgs.nix-mode
      epkgs.swiper
      epkgs.use-package
      epkgs.which-key
    ];
  };

  home.file = {
    ".emacs".source = ./emacs/emacsrc;
  };
}

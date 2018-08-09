{ pkgs, ... }:

{
  imports = [
    ../cfg/emacs.nix
    ../cfg/fzf.nix
    ../cfg/git.nix
    ../cfg/mupdf.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    dact
    gnupg
    htop
    ncdu
    pass
    ripgrep
    youtube-dl

    # Better userland for macOS
    coreutils
    fd
    findutils
    gnugrep
    gnused

    # Development
    go

    # Environments
    jupyterEnv
    latexEnv
    pandocEnv

    # Fonts
    fontconfig
    lato
    source-code-pro


    #Arq
    #Dash
    #iTerm2
    #OmniGraffle
    #TableFlip
  ];

  fonts.fontconfig.enableProfileFonts = true;

  #home.sessionVariables = {
  #  NIX_PATH = "$HOME/git/nixpkgs:nixpkgs=$HOME/git/nixpkgs:nixpkgs-unstable=$HOME/git/nixpkgs";
  #};

  xdg = {
    enable = true;
  };
}

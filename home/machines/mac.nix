{ pkgs, ... }:

{
  imports = [
    ../modules/emacs-init.nix

    ../cfg/base-unix.nix
    ../cfg/base-network.nix
    ../cfg/direnv.nix
    ../cfg/fzf.nix
    ../cfg/git.nix
    ../cfg/go.nix
    ../cfg/rust.nix
    #../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    #rustup
    #texlive.combined.scheme-full
    #danieldk.dact

    # Environments
    #jupyterEnv
    #latexEnv
    #pandocEnv

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

  home.sessionVariables = {
    #NIX_PATH = "nixpkgs=/Users/daniel/git/nixpkgs";
  };

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
  };

  home = {
    homeDirectory = "/Users/daniel";
    username = "daniel";
    stateVersion = "24.11";
  };
}

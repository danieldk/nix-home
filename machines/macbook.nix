{ pkgs, ... }:

{
  imports = [
    ../cfg/base-unix.nix
    ../cfg/base-network.nix
    ../cfg/direnv.nix
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

  xdg = {
    enable = true;
  };
}

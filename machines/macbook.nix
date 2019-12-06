{ pkgs, ... }:

{
  imports = [
    ../cfg/base-unix.nix
    ../cfg/base-network.nix
    ../cfg/direnv.nix
    ../cfg/emacs.nix
    ../cfg/fzf.nix
    ../cfg/git.nix
    #../cfg/mupdf.nix
    #../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    rustup
    texlive.combined.scheme-full
    danieldk.dact

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

  programs.zsh.initExtra = ''
    unset SSH_AUTH_SOCK
    test -r ~/.ssh-agent && eval "$(<~/.ssh-agent)" >/dev/null

    ssh-add -l &>/dev/null
    if [ "$?" -eq 2 ]; then
      (umask 066; ssh-agent -P "${pkgs.opensc}/lib/*" > ~/.ssh-agent)
      eval "$(<~/.ssh-agent)" >/dev/null
    fi
  '';

  xdg = {
    enable = true;
  };
}

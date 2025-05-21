{ pkgs, lib, ... }:

{
  imports = [
    ../modules/emacs-init.nix

    ../cfg/base-unix.nix
    ../cfg/base-network.nix
    ../cfg/direnv.nix
    ../cfg/fzf.nix
    ../cfg/git.nix
    ../cfg/go.nix
    ../cfg/kitty.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.activation.kitty = lib.hm.dag.entryAfter [ "writeBoundry" ] ''
    $DRY_RUN_CMD [ ! -d ~/Applications ] && mkdir ~/Applications
    $DRY_RUN_CMD [ -f ~/Applications/kitty.app ] && rm -rf ~/Applications/kitty.app
    $DRY_RUN_CMD cp -r ${pkgs.kitty}/Applications/kitty.app/ ~/Applications/
    $DRY_RUN_CMD chmod -R 755 ~/Applications/kitty.app
  '';

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

  programs.ssh.extraConfig = ''
    Match exec "/usr/local/bin/sft resolve -q  %h"
      ProxyCommand "/usr/local/bin/sft" proxycommand  %h
      UserKnownHostsFile "/Users/daniel/Library/Application Support/ScaleFT/proxycommand_known_hosts"
  '';

  xdg = {
    enable = true;
  };

  home = {
    homeDirectory = "/Users/daniel";
    username = "daniel";
    stateVersion = "24.11";
  };
}

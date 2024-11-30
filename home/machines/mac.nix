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
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.activation.kitty = lib.hm.dag.entryAfter ["writeBoundry"] ''
    $DRY_RUN_CMD [ -f ~/Applications/kitty.app ] && rm -rf ~/Applications/kitty.app
    $DRY_RUN_CMD cp -r ${pkgs.kitty}/Applications/kitty.app/ ~/Applications
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

  programs.kitty = {
    enable = true;
    themeFile = "Doom_Vibrant";
    font = {
      name = "IntoneMono Nerd Font Mono";
      package = pkgs.nerd-fonts.intone-mono;
      size = 17;
    };
    keybindings = {
      "cmd+enter" = "toggle_fullscreen";
    };
    settings = {
      cursor_trail = 1;
      remember_window_size = false;
      initial_window_width = 1024;
      initial_window_height = 768;
    };
  };

  xdg = {
    enable = true;
  };

  home = {
    homeDirectory = "/Users/daniel";
    username = "daniel";
    stateVersion = "24.11";
  };
}

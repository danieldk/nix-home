{ pkgs, specialArgs, ... }:

{
  imports = [
    ../cfg/plasma-desktop.nix
    ../cfg/base-unix.nix
    ../cfg/direnv.nix
    ../cfg/git.nix
    ../cfg/go.nix
    ../cfg/fzf.nix
    ../cfg/kitty.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    #code-cursor
    #gnome-boxes
    scaleft
    #kopia-ui
    prusa-slicer
    tidal-hifi
    #vscode
    zed-editor
  ];

  programs.ssh.matchBlocks = {
    "*" = {
      extraOptions = {
        IdentityAgent = "~/.1password/agent.sock";
      };
    };
  };

  home.stateVersion = "25.05";
}

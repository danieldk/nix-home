{ pkgs, specialArgs, ... }:

{
  imports = [
    ../cfg/base-unix.nix
    ../cfg/direnv.nix
    ../cfg/git.nix
    ../cfg/go.nix
    ../cfg/fzf.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
    specialArgs.vscode-server.homeModules.default
  ];

  home.packages = with pkgs; [
    nix-bundle
    nixpkgs-review
  ];

  services.vscode-server.enable = true;

  home.stateVersion = "24.05";
}

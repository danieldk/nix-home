{ pkgs, specialArgs, ... }:

{
  imports = [
    ../cfg/base-unix.nix
    ../cfg/direnv.nix
    ../cfg/git.nix
    ../cfg/fzf.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  # TODO: set up automounting and variables system-wide.
  home.sessionVariables = {
    TRANSFORMERS_CACHE = "/scratch/daniel/.cache/huggingface/hub";
    HUGGINGFACE_HUB_CACHE = "/scratch/daniel/.cache/huggingface/hub";
  };

  home.stateVersion = "24.05";
}

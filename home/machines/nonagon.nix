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

  programs.git.extraConfig = {
    credential.helper = "store";
  };

  programs.zsh.initExtra = ''
    # https://github.com/zellij-org/zellij/issues/1637#issuecomment-2325124511
    if [ -z "''${ZELLIJ}" ] && [ "''${TERM}" != 'dumb' ] && ( echo "$-" | grep "i" >/dev/null ) && command -v zellij >/dev/null; then
      if [ -S ''${SSH_AUTH_SOCK} ] && [ -w "/run/user/$(id -u)/" ] && ! [ -S "/run/user/$( id -u )/ssh_auth.sock" ]; then
          rm -f /run/user/$(id -u)/ssh_auth.sock
          ln -s "''${SSH_AUTH_SOCK}" "/run/user/$(id -u)/ssh_auth.sock"
      fi
    #exec zellij attach -c main
    fi

    if [ -S "/run/user/$(id -u)/ssh_auth.sock" ]; then
        export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh_auth.sock"
    fi
  '';
}

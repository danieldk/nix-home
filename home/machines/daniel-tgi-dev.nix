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

  #home.file.".config/nvim/lua/plugins/llama.lua".text = ''
  #  return {
  #    {
  #        'ggml-org/llama.vim',
  #    }
  #  }
  #'';

  # TODO: set up automounting and variables system-wide.
  home.sessionVariables = {
    TRANSFORMERS_CACHE = "/scratch/daniel/.cache/huggingface/hub";
    HUGGINGFACE_HUB_CACHE = "/scratch/daniel/.cache/huggingface/hub";
  };

  home.stateVersion = "24.05";

  programs.git.extraConfig = {
    credential.helper = "store";
  };

  programs.zsh.initContent = ''
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

  #systemd.user.services.llama-server = {
  #  Unit = {
  #    Description = "llama.cpp server";
  #  };
  #  Install = {
  #    WantedBy = [ "default.target" ];
  #  };
  #  Service = {
  #    ExecStart = ''
  #      ${pkgs.llama-cpp}/bin/llama-server \
  #        -hfr ggml-org/Qwen2.5-Coder-14B-Q8_0-GGUF \
  #        --hf-file qwen2.5-coder-14b-q8_0.gguf \
  #        --port 8012 -ngl 99 -fa -ub 1024 -b 1024 \
  #        --ctx-size 0 --cache-reuse 256 -mg 3 \
  #        --split-mode none
  #    '';
  #  };
  #};
}

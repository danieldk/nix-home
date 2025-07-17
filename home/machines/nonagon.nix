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
    #specialArgs.vscode-server.homeModules.default
  ];

  home.packages = with pkgs; [
    nix-bundle
    nixpkgs-review
  ];

  #services.vscode-server.enable = true;

  programs.zsh.initContent = ''
    # https://github.com/zellij-org/zellij/issues/1637#issuecomment-2325124511
    if [ -z "''${ZELLIJ}" ] && [ "''${TERM}" != 'dumb' ] && ( echo "$-" | grep "i" >/dev/null ) && command -v zellij >/dev/null; then
      if [ -S ''${SSH_AUTH_SOCK} ] && [ -w "/run/user/$(id -u)/" ] && ! [ -S "/run/user/$( id -u )/ssh_auth.sock" ]; then
          rm -f /run/user/$(id -u)/ssh_auth.sock
          ln -s "''${SSH_AUTH_SOCK}" "/run/user/$(id -u)/ssh_auth.sock"
      fi
    fi

    if [ -S "/run/user/$(id -u)/ssh_auth.sock" ]; then
        export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh_auth.sock"
    fi
  '';

  home.stateVersion = "25.11";
}

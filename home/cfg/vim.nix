{ pkgs, config, ... }:

{
  home.file.".config/nvim/lua".source = ./nvim/lua;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      LazyVim
    ];

    extraLuaConfig = ''
      -- bootstrap lazy.nvim, LazyVim and your plugins
      require("config.lazy");
    '';

    extraPackages = with pkgs; [
      fd
      git
      gcc
      gnutar
      nodePackages.prettier
      #pyright
      ripgrep
      #ruff
      zig
    ];

    withNodeJs = true;
    withPython3 = true;
  };
}

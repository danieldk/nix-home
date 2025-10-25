{ pkgs, config, ... }:

{
  home.file = {
    ".config/nvim/lua/config/autocmds.lua".source = ./nvim/lua/config/autocmds.lua;
    ".config/nvim/lua/config/keymaps.lua".source = ./nvim/lua/config/keymaps.lua;
    ".config/nvim/lua/config/options.lua".source = ./nvim/lua/config/options.lua;
    ".config/nvim/lua/config/lazy.lua".source = ./nvim/lua/config/lazy.lua;
    ".config/nvim/lua/plugins/zig.lua".source = ./nvim/lua/plugins/zig.lua;
    ".config/nvim/lua/plugins/neogit.lua".source = ./nvim/lua/plugins/neogit.lua;
    ".config/nvim/lua/plugins/nix-vim.lua".source = ./nvim/lua/plugins/nix-vim.lua;
    ".config/nvim/lua/plugins/mason.lua".source = ./nvim/lua/plugins/mason.lua;
  };

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
      lua51Packages.luarocks
      nodePackages.prettier
      ripgrep
      tree-sitter
      zig
    ];

    withNodeJs = true;
    withPython3 = true;
  };
}

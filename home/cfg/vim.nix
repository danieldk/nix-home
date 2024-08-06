{ pkgs, config, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
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
      nodePackages.prettier
      pyright
      ripgrep
      zig
    ];
  };
}

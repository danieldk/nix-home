{ pkgs, ... }:

{
  programs.vim = {
    enable = true;

    #settings = {
    #  relativenumber = true;
    #  number = true;
    #};

    plugins = with pkgs.vimPlugins; [
      colors-solarized
      ctrlp
      fugitive
    ];

    extraConfig = builtins.readFile vim/vimrc;
  };
}

{ pkgs, ... }:

{
  programs.vim = {
    enable = true;

    settings = {
      relativenumber = true;
      number = true;
    };

    plugins = [
      "colors-solarized"
      "ctrlp"
      "fugitive"
    ];

    extraConfig = builtins.readFile vim/vimrc;
  };
}

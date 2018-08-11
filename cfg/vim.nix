{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    #settings = {
    #  relativenumber = true;
    #  number = true;
    #};

    configure = {
      #pathogen.pluginNames = with pkgs.vimPlugins; [
      #  "colors-solarized"
      #];
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          colors-solarized
          ctrlp
          fugitive
        ];
      };

      customRC = builtins.readFile vim/vimrc;
    };
  };
}

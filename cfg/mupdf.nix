{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mupdf
  ];

  home.file = {
    "bin/mupdf".source = ./mupdf/mupdf;
  };
}

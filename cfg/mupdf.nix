{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  home.packages = with pkgs; [
    unstable.mupdf
  ];

  home.file = {
    "bin/mupdf".source = ./mupdf/mupdf;
  };
}

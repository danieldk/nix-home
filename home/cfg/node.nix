{ pkgs, ... }:

{
  home.file.".npmrc".text = ''
    min-release-age=7 # days
    ignore-scripts=true
  '';
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustChannels.stable.rust
  ];
}

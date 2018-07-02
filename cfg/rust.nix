{ pkgs, ... }:

{
  home.packages = with pkgs; [
    latest.rustChannels.stable.rust
  ];
}

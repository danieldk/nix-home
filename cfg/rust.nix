{ pkgs, ... }:

{
  home.packages = with pkgs; [
    latest.rustChannels.stable.rust
    danieldk.rustracer
  ];

  programs.zsh.initExtra = "export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src";
}

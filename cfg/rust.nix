{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #latest.rustChannels.stable.rust
    #latest.rustChannels.nightly.rust
    rustracer
  ];

  programs.zsh.initExtra = "export RUST_SRC_PATH=$(${pkgs.latest.rustChannels.stable.rust}/bin/rustc --print sysroot)/lib/rustlib/src/rust/src";
}

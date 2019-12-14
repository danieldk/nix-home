{ pkgs, ... }:

let
  rustStable = pkgs.mozilla.latest.rustChannels.stable.rust.override {
    extensions = [ "rust-src" ];
  };
in {
  home.packages = with pkgs; [
    #latest.rustChannels.stable.rust
    #latest.rustChannels.nightly.rust
    rustracer
  ];

  programs.zsh.initExtra = "export RUST_SRC_PATH=$(${rustStable}/bin/rustc --print sysroot)/lib/rustlib/src/rust/src";
}

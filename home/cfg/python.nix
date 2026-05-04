{ pkgs, ... }:

{
  programs.uv = {
    enable = true;
    settings = {
      exclude-newer = "7 days";
    };
  };
}

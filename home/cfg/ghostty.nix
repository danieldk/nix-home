{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    # Broken on macOS, we just want the config.
    package = pkgs.hello;
    settings = {
      font-size = 18;
      font-family = "MonoLisa";
    };
  };
}

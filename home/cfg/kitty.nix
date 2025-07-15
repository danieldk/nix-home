{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Doom_Vibrant";
    font = {
      name = "MonoLisa";
      #package = pkgs.nerd-fonts.intone-mono;
      size = 18;
    };
    keybindings = {
      "cmd+enter" = "toggle_fullscreen";
    };
    settings = {
      cursor_trail = 1;
      remember_window_size = false;
      initial_window_width = 1024;
      initial_window_height = 768;
      symbol_map = "U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b7,U+e700-U+e8ef,U+ed00-U+efc1,U+f000-U+f2ff,U+f000-U+f2e0,U+f300-U+f381,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font Mono";
    };
  };
}

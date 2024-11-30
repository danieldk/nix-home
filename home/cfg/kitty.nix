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
    };
  };
}

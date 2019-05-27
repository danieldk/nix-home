{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];

  programs.zsh.initExtra = ''
    ${pkgs.kitty}/bin/kitty + complete setup zsh | source /dev/stdin
  '';


  pam.sessionVariables = {
    # Kitty is complaining about old OpenGL drivers with the Wayland backend.
    KITTY_DISABLE_WAYLAND = 1;
  };

  xdg.configFile."kitty/kitty.conf".text = ''
    enable_audio_bell no
    font_size 10.0
    initial_window_width 800
    initial_window_height 600
    kitty_mod alt
    visual_bell_duration 0.05

    # Solarized dark

    background              #002b36
    foreground              #839496
    cursor                  #93a1a1

    selection_background    #81908f
    selection_foreground    #002831

    color0                  #073642
    color1                  #dc322f
    color2                  #859900
    color3                  #b58900
    color4                  #268bd2
    color5                  #d33682
    color6                  #2aa198
    color7                  #eee8d5
    color9                  #cb4b16
    color8                  #002b36
    color10                 #586e75
    color11                 #657b83
    color12                 #839496
    color13                 #6c71c4
    color14                 #93a1a1
    color15                 #fdf6e3
  '';
}

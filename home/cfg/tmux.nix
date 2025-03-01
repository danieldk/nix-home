{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    shortcut = "a";

    extraConfig = ''
       bind-key v split-window -h
       bind-key b split-window

       bind h select-pane -L
       bind j select-pane -D
       bind k select-pane -U
       bind l select-pane -R

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
    '';
  };
}

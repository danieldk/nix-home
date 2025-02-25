{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    #gnome-mpv
    google-chrome
    #pass-find-desktop
    _1password-gui
    signal-desktop
    slack
    #vivaldi
  ];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      font-size = 14;
    };
  };

  #home.file = {
  #  ".config/autostart/gnome-keyring-ssh.desktop".text = ''
  #    [Desktop Entry]
  #    Type=Application
  #    Name=SSH Key Agent
  #    Hidden=true
  #  '';
  #};

  #programs.mpv = {
  #  enable = true;
  #  config = {
      #hwdec = "nvdec";
      #vo = "gpu";
  #  };
  #};

  #services.gpg-agent = {
  #  enable = true;
  #  extraConfig = ''
  #    pinentry-program ${pkgs.pinentry_gnome}/bin/pinentry-gnome3
  #  '';
  #};
}

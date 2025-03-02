{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    #gnome-mpv
    google-chrome
    #pass-find-desktop
    #vivaldi
    obsidian
    protonmail-desktop
    signal-desktop
    slack
  ];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      font-family = "MonoLisa";
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

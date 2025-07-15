{ pkgs, nix-flatpak, ... }:

{
  # I prefer to use native Nix applications with sandboxing through
  # nixpak (see overlays/sandboxing). But since a recent upgrade,
  # portals require that the dynamic parts of .flatpak-info are
  # generated as well (e.g. instance-id). Use flatpaks until this
  # is fixed in nixpak.
  imports = [ nix-flatpak.homeManagerModules.nix-flatpak ];

  # Installing these through flatpak because I want them sandboxed.
  services.flatpak = {
  #  enable = true;
    packages = [
      "md.obsidian.Obsidian"
  #    "me.proton.Mail"
      "org.signal.Signal"
      #"com.slack.Slack"
    ];
  };

  home.packages = with pkgs; [
    #firefox
    #gnome-mpv
    google-chrome
    #pass-find-desktop
    #vivaldi
    #obsidian
    #signal-desktop-bin
    slack
  ];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      clipboard-read = "deny";
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

  programs.mpv = {
    enable = true;
    config = {
      hwdec = "vaapi";
      vo = "gpu";
    };
  };

  #services.gpg-agent = {
  #  enable = true;
  #  extraConfig = ''
  #    pinentry-program ${pkgs.pinentry_gnome}/bin/pinentry-gnome3
  #  '';
  #};
}

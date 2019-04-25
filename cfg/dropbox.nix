{ pkgs, ... }:

{
  xdg.configFile."autostart/dropbox.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Exec=${pkgs.dropbox-filesystem-agnostic}/bin/dropbox
    Terminal=false
    Name=Dropbox
    Categories=Network;FileTransfer;
    Comment=Sync your files across computers and to the web
    GenericName=File Synchronizer
    StartupNotify=false
  '';
}

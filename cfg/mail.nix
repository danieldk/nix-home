{ pkgs, config, ... }:

{
  accounts.email.accounts.fastmail = {
    primary = true;

    address = "me@danieldk.eu";
    passwordCommand = "${pkgs.pass}/bin/pass Mail/magnolia";
    realName = "Daniël de Kok";
    userName = "ddk@fastmail.fm";

    imap = {
      host = "imap.fastmail.com";
      port = 993;
      tls.enable = true;
    };

    smtp = {
      host = "smtp.fastmail.com";
      port = 465;
      tls.enable = true;
    };

    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
      flatten = ".";
      patterns = [ "*" "!.*" ];

      extraConfig.local = {
        Subfolders = "Verbatim";
      };
    };

    msmtp = {
      enable = true;
    };

    notmuch.enable = true;
  };

  home.packages = with pkgs; [
    mu
  ];

  home.file = {
  };

  programs.mbsync.enable = true;

  programs.notmuch = {
    enable = true;
    extraConfig = {
      maildir = {
        synchronize_flags = "true";
      };
    };
  };

  services.mbsync = {
    enable = true;
    postExec = "${pkgs.notmuch}/bin/notmuch --config=${config.xdg.configHome}/notmuch/notmuchrc new";
  };
}

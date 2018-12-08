{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    Dash
    iTerm2
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 3;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    maxJobs = 4;
    buildCores = 4;

    package = pkgs.nix;

    nixPath = [
      "darwin-config=$HOME/.config/nixpkgs/cfg/darwin.nix"
      "darwin=$HOME/.config/nixpkgs/darwin"
      "nixpkgs=$HOME/git/nixpkgs"
    ];

    trustedUsers = [ "daniel" "@admin" ];
  };

  nixpkgs = {
    # Bring the overlays into scope, from:
    # https://github.com/jwiegley/nix-config/blob/master/config/darwin.nix
    overlays =
      let path = ../overlays; in with builtins;
      map (n: import (path + ("/" + n)))
          (filter (n: match ".*\\.nix" n != null ||
                      pathExists (path + ("/" + n + "/default.nix")))
                  (attrNames (readDir path)));
  };

  system.defaults.NSGlobalDomain = {
    AppleKeyboardUIMode = 3;
    ApplePressAndHoldEnabled = false;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
    NSDocumentSaveNewDocumentsToCloud = false;
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;
    PMPrintingExpandedStateForPrint = true;
    PMPrintingExpandedStateForPrint2 = true;
  };

  system.defaults.dock = {
    autohide = true;
    showhidden = true;
    mru-spaces = false;
    static-only = true;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    QuitMenuItem = true;
    FXEnableExtensionChangeWarning = false;
  };

  system.defaults.trackpad = {
    Clicking = true;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}

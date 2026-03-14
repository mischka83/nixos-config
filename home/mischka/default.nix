{ pkgs, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/starship.nix
    ./shell/zsh.nix
    ./desktop/plasma.nix
    ./desktop/shortcuts.nix
    ./desktop/panel.nix
    ./desktop/theme.nix
    ./desktop/performance.nix
    ./desktop/krunner.nix
  ];

  home.username = "mischka";
  home.homeDirectory = "/home/mischka";
  home.stateVersion = "25.11";

  # XDG User Dirs automatisch erstellen
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.home-manager.enable = true;
}

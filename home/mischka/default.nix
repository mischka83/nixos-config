{ pkgs, ... }:

{
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

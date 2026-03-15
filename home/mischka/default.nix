{ pkgs, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/starship.nix
    ./shell/zsh.nix
    ./desktop/plasma/default.nix
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

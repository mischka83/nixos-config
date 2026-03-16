{ pkgs, ... }:

{
  imports = [
    ./programs/flatpak.nix
    ./programs/firefox.nix
    ./programs/git.nix
    ./programs/starship.nix
    ./programs/vscode.nix
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

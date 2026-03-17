{ lib, config, pkgs, ... }:

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

  // TODO: Avatar wird nicht angewendet
  # Avatar-Bild für KDE Plasma
  home.file.".face.icon" = {
    source = ../../assets/profil_mischka.jpg;
    force = true;
  };

  programs.home-manager.enable = true;
}

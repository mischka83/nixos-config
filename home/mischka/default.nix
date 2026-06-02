{ lib, config, pkgs, ... }:

{
  imports = [
    ../../modules/home/default.nix
  ];

  home.username = "mischka";
  home.homeDirectory = "/home/mischka";
  home.stateVersion = "26.05";

  profile.browsers = [ "vivaldi" "firefox" ];
  profile.desktop.niri.enable = true;

  # XDG User Dirs automatisch erstellen
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # TODO: Avatar wird nicht angewendet
  # Avatar-Bild für KDE Plasma
  home.file.".face.icon" = {
    source = ../../assets/profil_mischka.jpg;
    force = true;
  };

  programs.home-manager.enable = true;
}

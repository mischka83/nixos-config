{ lib, config, pkgs, ... }:

{
  imports = [
    ./programs/flatpak.nix
    ./programs/browser.nix
    ./programs/git.nix
    ./programs/starship.nix
    ./programs/vscode.nix
    ./programs/powershell.nix
    ./shell/zsh.nix
    ./desktop/plasma/default.nix
  ];

  home.username = "mischka";
  home.homeDirectory = "/home/mischka";
  home.stateVersion = "26.05";

  mischka.browser = "chrome";

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

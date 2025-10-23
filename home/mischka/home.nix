{ config, pkgs, inputs, ... }:

{
  imports = [
    ./user.nix
    ./zsh.nix
    ./vscode.nix
    ./dotfiles.nix
  ];

  # Git nur für diesen Benutzer
  programs.git = {
    enable = true;
    userName = "Christian Ewert";
    userEmail = "CEwert@gmx.net";
  };

  # Benutzerpakete
  home.packages = with pkgs; [
    # --- Productivity ---
    libreoffice qownnotes thunderbird stirling-pdf bitwarden-desktop

    # --- Media ---
    vlc gimp-with-plugins parabolic delfin

    # --- Communication ---
    ferdium teams-for-linux

    # --- CLI-Tools ---
    htop bat neofetch freshfetch ripgrep fd wget kitty imagemagick

    # --- File Management ---
    unzip unrar

    # --- Development Tools ---
    vscode gcc lazygit
  ];

}

{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/core/user.nix
    ./zsh.nix
    ./vscode.nix
    ./neovim.nix
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
    libreoffice drawio qownnotes thunderbird stirling-pdf bitwarden-desktop

    # --- Media ---
    vlc gimp-with-plugins parabolic delfin

    # --- Communication ---
    ferdium teams-for-linux

    # --- CLI-Tools ---
    htop bat neofetch freshfetch fastfetch ripgrep fd wget kitty imagemagick bind

    # --- File Management ---
    unzip unrar

    # --- Development Tools ---
    powershell gcc lazygit
  ];

}

{ config, pkgs, ... }:

{
    # Benutzerpakete
  home.packages = with pkgs; [
    # --- Productivity ---
    libreoffice drawio qownnotes thunderbird stirling-pdf bitwarden-desktop

    # --- Media ---
    vlc gimp-with-plugins parabolic delfin

    # --- Communication ---
    teams-for-linux

    # --- CLI-Tools ---
    htop bat neofetch freshfetch fastfetch ripgrep fd wget kitty imagemagick bind

    # --- File Management ---
    unzip unrar

    # --- Development Tools ---
    powershell gcc lazygit openssl

  ];
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}
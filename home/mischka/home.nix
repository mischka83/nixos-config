{ config, pkgs, inputs, ... }:

{
  imports = [
    #../../modules/core/user.nix
    ../../modules/home/vscode.nix
    ../../modules/home/zsh/default.nix
    #inputs.plasma-manager.homeModules.plasma-manager
  ];

  #programs.plasma-manager.enable = true;
  
  home = {
      username = "mischka";
      homeDirectory = "/home/mischka";
      stateVersion = "25.05";
  };

  # Git nur für diesen Benutzer
  programs.git = {
    enable = true;
    userName = "Christian Ewert";
    userEmail = "CEwert@gmx.net";
  };

  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/mischka/dotfiles/nvim";
    };
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

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./zsh.nix
  ];

  home.username = "mischka";
  home.homeDirectory = "/home/mischka";
  home.stateVersion = "25.05"; # Wichtig! Entspricht NixOS Version

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

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };

  # --- dotfiles ---
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/mischka/dotfiles/nvim";
    };
  };

}

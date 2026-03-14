{ pkgs, ... }:

{
  # KDE Plasma - Nur Fonts und Styling via Home Manager
  # Theme/Colors werden manuell in KDE Settings gesetzt

  # Qt Stil für KDE Apps
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };

  # GTK Stil (für nicht-KDE Apps)
  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze;
    };
    iconTheme = {
      name = "breeze-icons";
      package = pkgs.kdePackages.breeze-icons;
    };
    cursorTheme = {
      name = "breeze_cursors";
      size = 24;
    };
  };

  # Fonts
  home.packages = with pkgs; [
    # Nerd Fonts (monospace für Terminal/Editor)
    fira-code
    jetbrains-mono
    meslo-lg

    # KDE Theme Pakete
    kdePackages.breeze
    kdePackages.breeze-icons
  ];

  # Session Variable für Terminal
  home.sessionVariables = {
    TERM = "xterm-256color";
  };
}

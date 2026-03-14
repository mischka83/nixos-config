{ pkgs, ... }:

{
  # KDE Plasma Dark Theme Konfiguration
  xdg.configFile."kdeglobals" = {
    text = ''
      [General]
      ColorScheme=BreezeDark
      font=Noto Sans,11,-1,5,50,0,0,0,0,0
      menuFont=Noto Sans,11,-1,5,50,0,0,0,0,0
      smallestReadableFont=Noto Sans,8,-1,5,50,0,0,0,0,0
      toolBarFont=Noto Sans,11,-1,5,50,0,0,0,0,0

      [Icons]
      Theme=breeze-dark
    '';
  };

  # Nerd Fonts - für bessere Icon Support
  home.packages = with pkgs; [
    # Beliebte Nerd Fonts
    (nerd-fonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Meslo" ]; })

    # KDE Theme Pakete
    kdePackages.breeze
    kdePackages.breeze-icons
  ];

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
  };

  # Session Variable für Terminal
  home.sessionVariables = {
    TERM = "xterm-256color";
  };
}

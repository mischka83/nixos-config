{ pkgs, ... }:

{
  # KDE Plasma Dark Theme - Vollständige Konfiguration
  xdg.configFile."kdeglobals" = {
    text = ''
      [General]
      ColorScheme=BreezeDark
      font=Noto Sans,11,-1,5,50,0,0,0,0,0
      menuFont=Noto Sans,11,-1,5,50,0,0,0,0,0
      smallestReadableFont=Noto Sans,8,-1,5,50,0,0,0,0,0
      toolBarFont=Noto Sans,11,-1,5,50,0,0,0,0,0
      fixed=Monospace,10,-1,5,50,0,0,0,0,0

      [Icons]
      Theme=breeze-dark

      [Colors:Button]
      BackgroundAlternate=49,54,59
      BackgroundNormal=31,34,38
      DecorationFocus=61,174,233
      DecorationHover=61,174,233
      ForegroundActive=61,174,233
      ForegroundInactive=121,119,119
      ForegroundLink=41,128,185
      ForegroundNegative=218,68,83
      ForegroundNeutral=246,116,0
      ForegroundNormal=239,240,241
      ForegroundPositive=39,174,96
      ForegroundVisited=155,89,182

      [Colors:Selection]
      BackgroundAlternate=29,153,243
      BackgroundNormal=61,174,233
      DecorationFocus=61,174,233
      DecorationHover=61,174,233
      ForegroundActive=255,255,255
      ForegroundInactive=121,119,119
      ForegroundLink=41,128,185
      ForegroundNegative=218,68,83
      ForegroundNeutral=246,116,0
      ForegroundNormal=255,255,255
      ForegroundPositive=39,174,96
      ForegroundVisited=155,89,182

      [Colors:Tooltip]
      BackgroundAlternate=49,54,59
      BackgroundNormal=31,34,38
      DecorationFocus=61,174,233
      DecorationHover=61,174,233
      ForegroundActive=61,174,233
      ForegroundInactive=121,119,119
      ForegroundLink=41,128,185
      ForegroundNegative=218,68,83
      ForegroundNeutral=246,116,0
      ForegroundNormal=239,240,241
      ForegroundPositive=39,174,96
      ForegroundVisited=155,89,182

      [Colors:View]
      BackgroundAlternate=49,54,59
      BackgroundNormal=31,34,38
      DecorationFocus=61,174,233
      DecorationHover=61,174,233
      ForegroundActive=61,174,233
      ForegroundInactive=121,119,119
      ForegroundLink=41,128,185
      ForegroundNegative=218,68,83
      ForegroundNeutral=246,116,0
      ForegroundNormal=239,240,241
      ForegroundPositive=39,174,96
      ForegroundVisited=155,89,182

      [Colors:Window]
      BackgroundAlternate=49,54,59
      BackgroundNormal=31,34,38
      DecorationFocus=61,174,233
      DecorationHover=61,174,233
      ForegroundActive=61,174,233
      ForegroundInactive=121,119,119
      ForegroundLink=41,128,185
      ForegroundNegative=218,68,83
      ForegroundNeutral=246,116,0
      ForegroundNormal=239,240,241
      ForegroundPositive=39,174,96
      ForegroundVisited=155,89,182

      [WM]
      activeBackground=31,34,38
      activeBlend=239,240,241
      activeForeground=239,240,241
      inactiveBackground=49,54,59
      inactiveBlend=121,119,119
      inactiveForeground=121,119,119
    '';
  };

  # KDE Kurz-Shortcuts auch konfigurieren
  xdg.configFile."kglobalshortcutsrc" = {
    text = ''
      [kwin]
      Switch Window=Alt+Tab
      Window Close=Alt+F4
      Window Maximize=Meta+M
      Window Minimize=Meta+H
    '';
  };

  # Nerd Fonts - für bessere Icon Support in Terminal & Starship
  home.packages = with pkgs; [
    # Nerd Fonts (einzeln)
    fira-code
    jetbrains-mono
    meslo-lg

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

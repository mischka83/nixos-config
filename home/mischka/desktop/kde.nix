{ inputs, pkgs, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  programs.plasma = {
    enable = true;

    # Keyboard Shortcuts
    shortcuts = {
      "ActivityManager"."switch-to-activity-1" = "Meta+1";
      "ActivityManager"."switch-to-activity-2" = "Meta+2";
      "kwin"."Expose" = "Meta+E";
      "kwin"."Switch Window Down" = "Meta+Down";
      "kwin"."Switch Window Left" = "Meta+Left";
      "kwin"."Switch Window Right" = "Meta+Right";
      "kwin"."Switch Window Up" = "Meta+Up";
      "kwin"."Window Close" = "Alt+F4";
      "kwin"."Window Maximize" = "Meta+M";
      "kwin"."Window Minimize" = "Meta+H";
      "plasmashell"."activate application launcher" = "Meta";
    };

    # KWin (Window Manager)
    kwin = {
      edgeBarrier = 0;
      borderlessMaximizedWindows = true;
    };
  };

  # Panel-Konfiguration direkt schreiben - zuverlässiger als plasma-manager Script
  # force = true damit Home Manager die Datei immer überschreibt
  xdg.configFile."plasma-org.kde.plasma.desktop-appletsrc" = {
    force = true;
    text = ''
      [ActionPlugins][0]
      MiddleButton;NoModifier=org.kde.paste
      RightButton;NoModifier=org.kde.contextmenu

      [ActionPlugins][1]
      RightButton;NoModifier=org.kde.contextmenu

      [Containments][1]
      activityId=
      formfactor=0
      immutability=1
      lastScreen=0
      location=0
      plugin=org.kde.plasma.folder
      wallpaperplugin=org.kde.image

      [Containments][2]
      activityId=
      formfactor=2
      immutability=1
      lastScreen[$i]=0
      location=4
      plugin=org.kde.panel
      wallpaperplugin=org.kde.image

      [Containments][2][General]
      AppletOrder=3;4;5;6;7;8;9

      [Containments][2][Applets][3]
      immutability=1
      plugin=org.kde.plasma.kickoff

      [Containments][2][Applets][3][Configuration][General]
      icon=nix-snowflake
      favoritesPortedToKAstats=true

      [Containments][2][Applets][4]
      immutability=1
      plugin=org.kde.plasma.pager

      [Containments][2][Applets][5]
      immutability=1
      plugin=org.kde.plasma.appmenu

      [Containments][2][Applets][6]
      immutability=1
      plugin=org.kde.plasma.spacer

      [Containments][2][Applets][7]
      immutability=1
      plugin=org.kde.plasma.taskmanager

      [Containments][2][Applets][7][Configuration][Appearance]
      maxStripes=1
      showText=never

      [Containments][2][Applets][7][Configuration][General]
      groupingStrategy=1
      iconSize=32
      showOnlyMinimized=false
      showToolTips=true

      [Containments][2][Applets][8]
      immutability=1
      plugin=org.kde.plasma.spacer

      [Containments][2][Applets][9]
      activityId=
      formfactor=0
      immutability=1
      lastScreen=-1
      location=0
      plugin=org.kde.plasma.systemtray
      popupHeight=432
      popupWidth=432
      wallpaperplugin=org.kde.image

      [Containments][2][Applets][9][General]
      extraItems=org.kde.plasma.notifications,org.kde.plasma.cameraindicator,org.kde.plasma.mediacontroller,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.manage-inputmethod,org.kde.plasma.printmanager,org.kde.plasma.weather,org.kde.plasma.networkmanagement,org.kde.plasma.brightness,org.kde.plasma.volume,org.kde.kscreen,org.kde.plasma.keyboardindicator,org.kde.plasma.keyboardlayout,org.kde.plasma.bluetooth,org.kde.plasma.battery
      knownItems=org.kde.plasma.notifications,org.kde.plasma.cameraindicator,org.kde.plasma.mediacontroller,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.manage-inputmethod,org.kde.plasma.printmanager,org.kde.plasma.weather,org.kde.plasma.networkmanagement,org.kde.plasma.brightness,org.kde.plasma.volume,org.kde.kscreen,org.kde.plasma.keyboardindicator,org.kde.plasma.keyboardlayout,org.kde.plasma.bluetooth,org.kde.plasma.battery

      [Containments][2][Applets][10]
      immutability=1
      plugin=org.kde.plasma.digitalclock

      [Containments][2][Applets][10][Configuration][Appearance]
      showSeconds=Never

      [Containments][2][Applets][10][Configuration][General]
      showSeconds=false
      use24hFormat=2

      [ScreenMapping]
      itemsOnDisabledScreens=
    '';
  };

  # KDE Dark Theme via kdeglobals
  xdg.configFile."kdeglobals" = {
    force = true;
    text = ''
      [General]
      ColorScheme=BreezeDark
      font=Noto Sans,11,-1,5,50,0,0,0,0,0
      menuFont=Noto Sans,11,-1,5,50,0,0,0,0,0
      smallestReadableFont=Noto Sans,8,-1,5,50,0,0,0,0,0
      toolBarFont=Noto Sans,11,-1,5,50,0,0,0,0,0

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

  # Qt Stil - KDE verwaltet GTK selbst über breeze-gtk
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };

  # Nerd Fonts
  home.packages = with pkgs; [
    fira-code
    jetbrains-mono
    meslo-lg
    kdePackages.breeze
    kdePackages.breeze-icons
  ];

  home.sessionVariables = {
    TERM = "xterm-256color";
  };
}

{ inputs, pkgs, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  programs.plasma = {
    enable = true;

    # Panels - Taskleiste oben mit Dark Theme
    panels = [
      {
        alignment = "center";
        floating = false;
        height = 34;
        hiding = "none";
        location = "top";
        screen = "all";

        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake";
                favoriteSystemActions = "logout";
              };
            };
          }
          {
            name = "org.kde.plasma.appmenu";
          }
          "org.kde.plasma.pager"
          {
            name = "org.kde.plasma.taskmanager";
            config = {
              General = {
                groupingStrategy = 1;
                showOnlyMinimized = false;
                launchersGroup = 0;
                showToolTips = true;
                iconSize = 32;
                forceDiscreteGpu = false;
              };
              Appearance = {
                maxStripes = 1;
                showText = "never";
                thumbnailWindow = true;
              };
            };
          }
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

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

  # XDG Config Files - für Dark Theme Konfiguration
  xdg.configFile = {
    # KDE Global Settings - Dark Theme
    "kdeglobals".text = ''
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

    # Plasma Shell - weitere Anpassungen
    "plasmarc".text = ''
      [PlasmaViews][Panel 0]
      thickness=34
      alignment=center
      floating=false
    '';
  };

  # Nerd Fonts
  home.packages = with pkgs; [
    fira-code
    jetbrains-mono
    meslo-lg
    kdePackages.breeze
    kdePackages.breeze-icons
  ];

  # Qt Stil
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };

  # GTK Stil
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

  # Session Variable
  home.sessionVariables = {
    TERM = "xterm-256color";
  };
}

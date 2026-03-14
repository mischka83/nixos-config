{ inputs, pkgs, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  programs.plasma = {
    enable = true;

    # Panels - Taskleiste oben, transparent, nicht schwebend
    panels = [
      {
        alignment = "left";
        floating = false;
        height = 34;
        hiding = "none";
        location = "top";
        screen = "all";
        opacity = "translucent";

        widgets = [
          # 1. Startmenü (Kickoff mit Nix-Icon)
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake";
              };
            };
          }

          # 2. Virtuelle Desktops (Pager)
          {
            name = "org.kde.plasma.pager";
          }

          # 3. Globales Menü
          {
            name = "org.kde.plasma.appmenu";
          }

          # 4. Platzhalter links
          {
            name = "org.kde.plasma.spacer";
          }

          # 5. Fenster Icons OHNE Titel
          {
            name = "org.kde.plasma.taskmanager";
            config = {
              General = {
                groupingStrategy = 1;
                showOnlyMinimized = false;
                showToolTips = true;
                iconSize = 32;
              };
              Appearance = {
                maxStripes = 1;
                showText = "never";
              };
            };
          }

          # 6. Platzhalter rechts
          {
            name = "org.kde.plasma.spacer";
          }

          # 7. System Tray
          {
            name = "org.kde.plasma.systemtray";
          }

          # 8. Uhr
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              General = {
                showSeconds = false;
                use24hFormat = 1;
              };
            };
          }
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

  # Session Variable
  home.sessionVariables = {
    TERM = "xterm-256color";
  };
}

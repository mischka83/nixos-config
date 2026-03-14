{ inputs, pkgs, ... }:

{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs.plasma = {
    enable = true;

    # KDE Theme und Appearance
    theme = "breeze-dark";
    colorScheme = "BreezeDark";
    cursor = {
      theme = "breeze_cursors";
      size = 24;
    };

    # Panels - Taskleiste oben
    panels = [
      {
        alignment = "center";
        colorScheme = "BreezeDark";
        height = 34;
        hiding = "none";
        location = "top";
        screen = 0;

        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General.icon = "nix-snowflake";
            };
          }
          "org.kde.plasma.pager"
          "org.kde.plasma.taskmanager"
          {
            name = "org.kde.plasma.systemtray";
          }
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    # Shortcuts
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
      focus = "Sloppy";
    };

    # Fonts
    fonts = {
      general = {
        family = "Noto Sans";
        pointSize = 11;
      };
      menu = {
        family = "Noto Sans";
        pointSize = 11;
      };
      monospace = {
        family = "JetBrains Mono";
        pointSize = 10;
      };
    };

    # Hintergrundbild
    wallpaper = null;  # Setze hier einen Pfad: /path/to/wallpaper.png
  };

  # Nerd Fonts
  home.packages = with pkgs; [
    fira-code
    jetbrains-mono
    meslo-lg

    # KDE Theme Pakete
    kdePackages.breeze
    kdePackages.breeze-icons
  ];

  # Qt Stil
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

  # Session Variable
  home.sessionVariables = {
    TERM = "xterm-256color";
  };
}

{ inputs, pkgs, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  programs.plasma = {
    enable = true;

    # Panels - Taskleiste oben
    panels = [
      {
        alignment = "center";
        floating = false;
        height = 34;
        hiding = "none";
        location = "top";
        screen = 0;

        widgets = [
          {
            name = "org.kde.plasma.kickoff";
          }
          {
            name = "org.kde.plasma.pager";
          }
          {
            name = "org.kde.plasma.taskmanager";
          }
          {
            name = "org.kde.plasma.systemtray";
          }
          {
            name = "org.kde.plasma.digitalclock";
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

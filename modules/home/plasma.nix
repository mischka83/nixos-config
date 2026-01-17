{ config, pkgs, ... }:

{
  programs.plasma = {
    enable = true;

    # 🌟 Workspace & Appearance
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";

      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };

      iconTheme = "Papirus-Dark";
    };

    # 🖥 Virtual Desktops
    kwin = {
      virtualDesktops = {
        number = 4; # 2x2 Grid in GUI einstellen
      };

      # ✨ Effekte & Blur
      effects = {
        blur.enable = true;
        translucency.enable = true;
        #backgroundContrast.enable = true;
      };

    };

    # 🔤 Fonts
    fonts = {
      general = {
        family = "JetBrains Mono";
        pointSize = 12;
      };
    };

    # ⌨️ Shortcuts
    shortcuts = {
      global = {
        showDesktop = "Meta+D";
      };

      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Quick Tile Window to Left"  = "Meta+Left";
        "Quick Tile Window to Right" = "Meta+Right";
        "Quick Tile Window to Top"   = "Meta+Up";
        "Quick Tile Window to Bottom" = "Meta+Down";
      };
    };

    # 🖥 Panels & Widgets
    panels = [
      {
        location = "bottom";
        floating = true;
        height = 40;
        screen = 0;

        widgets = [
          { name = "org.kde.plasma.kickoff"; }

          # Pager / Desktop Switcher
          { name = "org.kde.plasma.pager"; }

          # Task Manager mit Favoriten
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                  "applications:firefox.desktop"
                  "applications:code.desktop"
                  "applications:bitwarden.desktop"
                ];
              };
            };
          }

          # System Tray + Clock
          { name = "org.kde.plasma.systemtray"; }
          { name = "org.kde.plasma.digitalclock"; }
        ];
      }

      {
        location = "bottom";
        floating = true;
        height = 40;
        screen = 1;

        widgets = [
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                  "applications:firefox.desktop"
                  "applications:code.desktop"
                  "applications:bitwarden.desktop"
                ];
              };
            };
          }

          { name = "org.kde.plasma.pager"; }
        ];
      }
    ];
  };
}

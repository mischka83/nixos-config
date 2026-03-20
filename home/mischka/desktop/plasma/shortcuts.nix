{ ... }:

{
  # KRunner
  programs.plasma.krunner.shortcuts = {
    launch               = "Meta+Space";
    runCommandOnClipboard = "Meta+Shift+V";
  };

  programs.plasma.shortcuts = {
    # Dolphin (Dateimanager)
    "services/org.kde.dolphin.desktop"._launch = "Meta+E";

    # Konsole (Terminal)
    "services/org.kde.konsole.desktop"._launch = "Meta+Return";

    # Screenshots über Spectacle
    "org.kde.spectacle.desktop" = {
      "CaptureEntireScreen"            = "Print";
      "RectangularRegionScreenCapture" = "Meta+Shift+S";
      "CaptureActiveWindow"            = "Meta+Print";
    };

    # Session: Bildschirm sperren
    ksmserver."Lock Session" = "Meta+L";

    # Meta+Q freigeben: Aktivitätenwechsler entfernen
    plasmashell."manage activities" = "none";

    # KWin (Fensterverwaltung)
    kwin = {
      # Meta+E fuer Dolphin freigeben (war bisher Fenster-Uebersicht)
      Expose = "Meta+F9";

      # Virtuelle Desktops wechseln
      "Switch to Desktop 1"        = "Meta+1";
      "Switch to Desktop 2"        = "Meta+2";
      "Switch to Next Desktop"     = "Meta+Ctrl+Right";
      "Switch to Previous Desktop" = "Meta+Ctrl+Left";

      # Aktives Fenster zu Desktop verschieben
      "Window to Desktop 1" = "Meta+Shift+1";
      "Window to Desktop 2" = "Meta+Shift+2";

      # Legacy-KWin-Action-IDs explizit auf "none" halten, damit alte Fehlzuordnungen nicht wieder auftauchen
      "Quick Tile Window to the Left"   = "none";
      "Quick Tile Window to the Right"  = "none";
      "Quick Tile Window to the Top"    = "none";
      "Quick Tile Window to the Bottom" = "none";

      # Fenster andocken: korrekte KWin-Action-IDs (per D-Bus verifiziert)
      "Window Quick Tile Left"   = "Meta+Left";
      "Window Quick Tile Right"  = "Meta+Right";
      "Window Quick Tile Top"    = "Meta+Up";
      "Window Quick Tile Bottom" = "Meta+Down";

      # Fenster-Zustand
      "Window Close"    = [ "Alt+F4" "Meta+Q" ];
      Maximize           = "none";
      Minimize           = "none";
      "Window Maximize" = "Meta+M";
      "Window Minimize" = "Meta+N";
      "Show Desktop"    = "Meta+D";
    };
  };
}

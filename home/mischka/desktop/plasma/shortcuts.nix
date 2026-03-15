{ ... }:

{
  # KRunner
  programs.plasma.krunner.shortcuts.launch = "Meta+Space";
  programs.plasma.krunner.shortcuts.runCommandOnClipboard = "Meta+Shift+V"; # optional

  # Dolphin (wie Windows-Explorer)
  programs.plasma.shortcuts."services/org.kde.dolphin.desktop"._launch = "Meta+E";

  # KWin (Fensterverwaltung)
  programs.plasma.shortcuts.kwin = {
    "Switch to Desktop 1" = "Meta+1";
    "Switch to Desktop 2" = "Meta+2";

    # Aktives Fenster an Bildschirmränder andocken
    "Window Quick Tile Left" = "Meta+Left";
    "Window Quick Tile Right" = "Meta+Right";
    "Window Quick Tile Top" = "Meta+Up";
    "Window Quick Tile Bottom" = "Meta+Down";

    # Optional: Fenster maximieren/minimieren
    "Window Maximize" = "Meta+M";
    "Window Minimize" = "Meta+N";
  };
}

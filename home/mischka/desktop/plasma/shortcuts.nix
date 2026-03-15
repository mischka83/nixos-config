{ ... }:

{
  # KRunner
  programs.plasma.krunner.shortcuts.launch = "Meta+Space";
  programs.plasma.krunner.shortcuts.runCommandOnClipboard = "Meta+Shift+V"; # optional

  # Dolphin
  # programs.plasma.dolphin.shortcuts.launch = "Meta+E";

  # KWin (Fensterverwaltung)
  programs.plasma.shortcuts.kwin = {
    "Switch to Desktop 1" = "Meta+1";
    "Switch to Desktop 2" = "Meta+2";

    # Window Tiling (intern: QuickTileWindow...)
    "QuickTileWindowLeft"  = "Meta+Left";
    "QuickTileWindowRight" = "Meta+Right";
    "QuickTileWindowUp"    = "Meta+Up";
    "QuickTileWindowDown"  = "Meta+Down";

    # Optional: Fenster maximieren/minimieren
    "Maximize"             = "Meta+M";
    "Minimize"             = "Meta+N";
  };
}

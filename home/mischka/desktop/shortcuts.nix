{ ... }:

{
  programs.plasma.krunner.shortcuts.launch = "Meta+Space";
  programs.plasma.krunner.shortcuts.runCommandOnClipboard = "Meta+Shift+V"; # optional

  programs.plasma.shortcuts.kwin = {
    "Switch to Desktop 1" = "Meta+1";
    "Switch to Desktop 2" = "Meta+2";
  };
}

{ config, lib, pkgs, ... }:

let
  cfg = config.programs.plasma;
in
{
  programs.plasma.krunner = {
    # Optionen, wie wir sie auch in den anderen Modulen definieren würden
    position = "center";
    activateWhenTypingOnDesktop = true;
    historyBehavior = "enableSuggestions";

    shortcuts = {
      launch = "Meta+Space";
      runCommandOnClipboard = "Meta+Shift+V";
    };
  };

  programs.plasma.configFile.krunnerrc = lib.mkMerge [
    (lib.mkIf (cfg.krunner.position != null) {
      General.FreeFloating = cfg.krunner.position == "center";
    })
    (lib.mkIf (cfg.krunner.activateWhenTypingOnDesktop != null) {
      General.ActivateWhenTypingOnDesktop = cfg.krunner.activateWhenTypingOnDesktop;
    })
    (lib.mkIf (cfg.krunner.historyBehavior != null) {
      General.historyBehavior = (
        if cfg.krunner.historyBehavior == "enableSuggestions" then
          "CompletionSuggestion"
        else if cfg.krunner.historyBehavior == "enableAutoComplete" then
          "ImmediateCompletion"
        else
          "Disabled"
      );
    })
  ];

  programs.plasma.shortcuts."services/org.kde.krunner.desktop" = lib.mkMerge [
    (lib.mkIf (cfg.krunner.shortcuts.launch != null) {
      _launch = cfg.krunner.shortcuts.launch;
    })
    (lib.mkIf (cfg.krunner.shortcuts.runCommandOnClipboard != null) {
      RunClipboard = cfg.krunner.shortcuts.runCommandOnClipboard;
    })
  ];
}

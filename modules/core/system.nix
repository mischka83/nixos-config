{ config, pkgs, versions, ... }:

{
  ##############################################
  # 🕰️ Timezone & Clock
  ##############################################
  time.timeZone = "Europe/Berlin";
  
  ##############################################
  # 🌐 Internationalization (i18n)
  ##############################################
  i18n = {
    defaultLocale = "de_DE.UTF-8";

    # 
    extraLocaleSettings = builtins.listToAttrs (map (lc: {
      name = lc;
      value = "de_DE.UTF-8";
    }) [
      "LC_ADDRESS"
      "LC_IDENTIFICATION"
      "LC_MEASUREMENT"
      "LC_MONETARY"
      "LC_NAME"
      "LC_NUMERIC"
      "LC_PAPER"
      "LC_TELEPHONE"
      "LC_TIME"
    ]);
  };

  # ⌨️ Keyboard Layout
  console.keyMap = "de";

  ##############################################
  # 🧩 System Version
  ##############################################
  system.stateVersion = versions.systemStateVersion;
}
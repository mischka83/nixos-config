{ config, pkgs, ... }:

{
  i18n = {
    defaultLocale = "de_DE.UTF-8";

    # Alle LC_…-Variablen auf denselben Wert setzen
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
}
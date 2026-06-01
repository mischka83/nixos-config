{ config, lib, ... }:

let
  enableChrome = config.mischka.browser == "chrome";
in
{
  programs.google-chrome = {
    enable = enableChrome;
    plasmaSupport = true;
    commandLineArgs = [
      "--disable-background-networking"
      "--disable-features=AutofillServerCommunication,MediaRouter,OptimizationHints,Translate"
      "--disable-sync"
      "--lang=de"
      "--password-store=kwallet6"
    ];
  };

  warnings = lib.optional enableChrome ''
    Google Chrome ist aktiv. Erweiterungen wie Bitwarden, uBlock Origin,
    Privacy Badger, Dark Reader, SponsorBlock und Refined GitHub lassen sich
    hier nicht so sauber deklarativ wie bei Firefox abbilden und muessen in
    Chrome manuell installiert werden.
  '';
}

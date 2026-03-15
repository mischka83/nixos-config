{ pkgs, ... }:
let
  addons = pkgs.nur.repos.rycee.firefox-addons;
in
{
  programs.firefox = {
    enable = true;
    profiles.mischka = {
      name = "mischka";

      extensions.packages = with addons; [
        bitwarden          # Passwort-Manager
        ublock-origin      # Werbung & Tracker blockieren
        privacy-badger     # Zusätzlicher Tracking-Schutz (EFF)
        darkreader         # Dark Mode für alle Seiten
        sponsorblock       # YouTube-Sponsoren überspringen
        refined-github     # Verbessertes GitHub-Interface
      ];

      settings = {
        # --- Telemetrie deaktivieren ---
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "app.shield.optoutstudies.enabled" = false;

        # --- Tracking Protection ---
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;

        # --- HTTPS-Only Mode ---
        "dom.security.https_only_mode" = true;

        # --- Sauberer Startbildschirm ---
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # --- Suchleiste aufgeräumt ---
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.history" = true;
        "browser.urlbar.suggest.bookmark" = true;

        # --- Downloads: immer Speicherort erfragen ---
        "browser.download.useDownloadDir" = false;

        # --- UI-Kleinigkeiten ---
        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };
  };
}

{ config, lib, ... }:

let
  browser = config.mischka.browser;
  browserDesktopEntry =
    if browser == "firefox" then
      "firefox.desktop"
    else if browser == "vivaldi" then
      "vivaldi-stable.desktop"
    else
      "google-chrome.desktop";
  browserCommand =
    if browser == "firefox" then
      "firefox"
    else if browser == "vivaldi" then
      "vivaldi-stable"
    else
      "google-chrome-stable";
in
{
  imports = [
    ./firefox.nix
    ./chrome.nix
    ./vivaldi.nix
  ];

  options.mischka.browser = lib.mkOption {
    type = lib.types.enum [ "firefox" "chrome" "vivaldi" ];
    default = "firefox";
    example = "chrome";
    description = "Welcher Browser aktiv sein soll.";
  };

  config = {
    home.sessionVariables.BROWSER = browserCommand;

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ browserDesktopEntry ];
        "x-scheme-handler/about" = [ browserDesktopEntry ];
        "x-scheme-handler/http" = [ browserDesktopEntry ];
        "x-scheme-handler/https" = [ browserDesktopEntry ];
        "x-scheme-handler/unknown" = [ browserDesktopEntry ];
      };
    };
  };
}

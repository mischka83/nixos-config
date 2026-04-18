{ config, lib, ... }:

let
  browser = config.mischka.browser;
  browserDesktopEntry =
    if browser == "firefox" then
      "firefox.desktop"
    else
      "google-chrome.desktop";
  browserCommand =
    if browser == "firefox" then
      "firefox"
    else
      "google-chrome-stable";
in
{
  imports = [
    ./firefox.nix
    ./chrome.nix
  ];

  options.mischka.browser = lib.mkOption {
    type = lib.types.enum [ "firefox" "chrome" ];
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

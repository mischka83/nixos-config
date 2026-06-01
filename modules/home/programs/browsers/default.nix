{ config, lib, ... }:

let
  browserMeta = {
    firefox = {
      desktopEntry = "firefox.desktop";
      command = "firefox";
    };
    vivaldi = {
      desktopEntry = "vivaldi-stable.desktop";
      command = "vivaldi-stable";
    };
    chrome = {
      desktopEntry = "google-chrome.desktop";
      command = "google-chrome-stable";
    };
  };
  browsers = config.profile.browsers;
  primaryBrowser = builtins.head browsers;
  primaryBrowserMeta = browserMeta.${primaryBrowser};
in
{
  imports = [
    ./firefox.nix
    ./chrome.nix
    ./vivaldi.nix
  ];

  options.profile.browsers = lib.mkOption {
    type = lib.types.listOf (lib.types.enum [ "firefox" "chrome" "vivaldi" ]);
    default = [ "firefox" ];
    apply = browsers:
      if browsers == [ ] then
        [ "firefox" ]
      else
        lib.unique browsers;
    example = [ "firefox" "vivaldi" ];
    description = "Welche Browser installiert werden sollen. Der erste Eintrag ist der Standardbrowser.";
  };

  config = {
    home.sessionVariables.BROWSER = primaryBrowserMeta.command;

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ primaryBrowserMeta.desktopEntry ];
        "x-scheme-handler/about" = [ primaryBrowserMeta.desktopEntry ];
        "x-scheme-handler/http" = [ primaryBrowserMeta.desktopEntry ];
        "x-scheme-handler/https" = [ primaryBrowserMeta.desktopEntry ];
        "x-scheme-handler/unknown" = [ primaryBrowserMeta.desktopEntry ];
      };
    };
  };
}

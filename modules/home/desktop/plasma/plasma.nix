{ ... }:

{
  programs.plasma = {
    enable = true;

    kwin = {
      virtualDesktops = {
        number = 2;
        rows = 1;
      };
    };

    workspace = {
      clickItemTo = "select";
    };

    powerdevil = {
      AC = {
        powerButtonAction = "sleep";
        displayBrightness = 100;
        turnOffDisplay = {
          idleTimeout = 600;              # 10 Minuten
          idleTimeoutWhenLocked = 600;    # 10 Minuten
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 300;              # 5 Minuten
        };
      };
      battery = {
        powerButtonAction = "sleep";
        displayBrightness = 70;
        turnOffDisplay = {
          idleTimeout = 300;              # 5 Minuten
          idleTimeoutWhenLocked = "immediately";
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 120;              # 2 Minuten
        };
      };
    };

    session = {
      general = {
        askForConfirmationOnLogout = false;
      };
      sessionRestore = {
        restoreOpenApplicationsOnLogin = "onLastLogout";
      };
    };
  };
}

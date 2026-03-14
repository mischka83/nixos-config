{ ... }:

{
  programs.plasma.panels = [
    {
      location = "top";
      height = 36;
      floating = false;

      widgets = [

        # Nix Startmenu
        {
          kickoff = {
            icon = "nix-snowflake-white";
          };
        }

        # Workspace Switcher
        "org.kde.plasma.pager"

        # Global Menu
        "org.kde.plasma.appmenu"

        # Spacer links
        "org.kde.plasma.panelspacer"

        # Program Icons (zentriert)
        {
          iconTasks = {
            iconsOnly = true;

            settings = {
              showToolTips = false;
            };
          };
        }

        # Spacer rechts
        "org.kde.plasma.panelspacer"

        # System tray
        "org.kde.plasma.systemtray"

        # Clock
        "org.kde.plasma.digitalclock"
      ];
    }
  ];
}

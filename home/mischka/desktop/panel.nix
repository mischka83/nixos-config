{ ... }:

{
  programs.plasma.panels = [
    {
      location = "top";       # Panel oben
      height = 36;            # Höhe in Pixel
      floating = false;        # Fixiert, nicht schwebend
      lengthMode = "fill";     # Panel füllt die gesamte Breite
      hiding = "none";         # Nicht automatisch ausblenden
      opacity = "opaque";      # Panel vollständig sichtbar

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

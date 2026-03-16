{ config, pkgs, ... }:

{
  services.displayManager = {
    sddm = {
      enable = true;

      # Wayland-Backend fuer SDDM aktivieren (empfohlen fuer KDE Plasma/Wayland)
      wayland.enable = true;

      # Aktives SDDM-Theme (muss auch in extraPackages vorhanden sein)
      # Alternativen: "breeze" (KDE-Standard), "sddm-astronaut-theme"
      theme = "sddm-chili-theme";
    };

    # Automatischen Login deaktiviert lassen (sicherer)
    # Zum Aktivieren: enable = true und user setzen
    autoLogin = {
      enable = false;
      # user = "mischka";
    };

    # Theme-Pakete bereitstellen, damit SDDM sie finden kann.
    # sddm-astronaut-theme ist als Reserve eingebunden, aktuell nicht aktiv.
    extraPackages = with pkgs; [
      sddm-chili-theme
      sddm-astronaut-theme
    ];
  };
}

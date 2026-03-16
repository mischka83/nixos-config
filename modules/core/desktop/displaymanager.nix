{ lib, ... }:

{
  services.displayManager = {
    sddm = {
      enable = true;

      # mkForce nötig, da das silentSDDM-Modul wayland.enable intern auf
      # !xserver.enable setzt – wir erzwingen Wayland explizit.
      wayland.enable = lib.mkForce true;

      # Theme und extraPackages werden vollständig durch das silentSDDM-Modul gesetzt.
      # Siehe modules/core/desktop/sddm-silent.nix
    };

    # Automatischen Login deaktiviert lassen (sicherer)
    # Zum Aktivieren: enable = true und user setzen
    autoLogin = {
      enable = false;
      # user = "mischka";
    };
  };
}

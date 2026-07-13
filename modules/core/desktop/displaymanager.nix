{ lib, ... }:

{
  services.displayManager = {
    sddm = {
      enable = true;

      # NVIDIA + SDDM Wayland can intermittently fail early with:
      # "Failed to open drm node ... No suitable DRM devices".
      # Run the greeter on X11 for reliability; Plasma sessions can still use Wayland.
      wayland.enable = lib.mkForce false;

      # Keep the generated sddm.conf aligned with the X11 backend.
      settings.General.DisplayServer = lib.mkForce "x11";

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

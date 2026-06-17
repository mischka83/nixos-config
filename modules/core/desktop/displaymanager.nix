{ lib, ... }:

{
  services.displayManager = {
    sddm = {
      enable = true;

      # NVIDIA + SDDM Wayland can intermittently fail early with:
      # "Failed to open drm node ... No suitable DRM devices".
      # Run the greeter on X11 for reliability; Plasma sessions can still use Wayland.
      wayland.enable = lib.mkForce true;

      # Force the generated sddm.conf to X11 backend during troubleshooting.
      # This avoids accidental Wayland greeter startups caused by module interactions.
      # settings.General.DisplayServer = lib.mkForce "x11";

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

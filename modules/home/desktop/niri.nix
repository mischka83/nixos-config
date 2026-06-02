{ lib, config, ... }:

let
  cfg = config.profile.desktop.niri;
in
{
  options.profile.desktop.niri.enable = lib.mkEnableOption "Niri + Noctalia desktop profile";

  config = lib.mkIf cfg.enable {
    # Noctalia configuration module. Startup itself is handled by Niri.
    programs.noctalia-shell = {
      enable = true;
      systemd.enable = false;
      settings = {
        colorSchemes.darkMode = true;
      };
    };

    # Keep Niri-specific customizations in a separate include file.
    xdg.configFile."niri/noctalia-autostart.kdl".text = ''
      // Start Noctalia automatically in Niri sessions.
      spawn-at-startup "noctalia-shell"

      // Include Noctalia generated theme snippets when available.
      include "./noctalia.kdl"
    '';

    # If niri config already exists, inject our include exactly once.
    # If it does not exist yet (first Niri login), we leave it untouched.
    home.activation.ensureNiriNoctaliaInclude = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      cfg="$HOME/.config/niri/config.kdl"
      if [ -f "$cfg" ]; then
        if ! grep -Fq 'include "./noctalia-autostart.kdl"' "$cfg"; then
          printf '\ninclude "./noctalia-autostart.kdl"\n' >> "$cfg"
        fi
      fi
    '';
  };
}

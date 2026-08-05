{ lib, pkgs, ... }:

let
  caelestiaSession = pkgs.runCommand "caelestia-session" {
    passthru.providedSessions = [ "caelestia" ];
  } ''
    mkdir -p "$out/share/wayland-sessions"
    cat > "$out/share/wayland-sessions/caelestia.desktop" <<EOF
[Desktop Entry]
Name=Caelestia
Comment=Hyprland session with Caelestia Shell
Exec=${pkgs.writeShellScript "start-caelestia-session" ''
  export XDG_CURRENT_DESKTOP=Caelestia
  export XDG_SESSION_DESKTOP=caelestia
  exec ${pkgs.hyprland}/bin/Hyprland
''}
Type=Application
DesktopNames=Caelestia
EOF
  '';
in

{
  # Add Hyprland as an additional Wayland session in SDDM.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Expose a dedicated "Caelestia" entry in the login session picker.
  services.displayManager.sessionPackages = [ caelestiaSession ];

  # Keep Plasma as default login session while exposing Niri + Hyprland.
  services.displayManager.defaultSession = lib.mkForce "plasma";
}

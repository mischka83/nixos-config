# Caelestia/Hyprland Keybindings Cheat Sheet (DE Layout)

Hinweis: In deiner Konfiguration ist Mod = Super.

## Starten und Basis

- Super + Return: Terminal starten (alacritty)
- Super + Leertaste: App-Launcher starten (fuzzel)
- Super + D: App-Launcher starten (fuzzel)
- Super + Q: Aktives Fenster schliessen
- Super + F: Fullscreen fuer aktives Fenster umschalten
- Super + Shift + E: Hyprland-Session beenden

## Fenstergroesse im Tiling anpassen

- Super + Minus: Breite verkleinern
- Super + Plus: Breite vergroessern
- Super + Equal: Breite vergroessern (Fallback je nach Layout/Keysym)
- Super + Shift + Minus: Hoehe verkleinern
- Super + Shift + Plus: Hoehe vergroessern
- Super + Shift + Equal: Hoehe vergroessern (Fallback je nach Layout/Keysym)

## Netzwerk und Monitore

- Super + Shift + V: VPN-Profil verbinden/trennen (fuzzel-Menue)
- Super + Shift + D: Monitorprofil umschalten (kanshi/fuzzel-Menue)

## Monitorprofile (Kanshi)

- home
- work
- work-external-only
- home-external-only
- laptop-only

## Konfig-Quellen

- Hyprland-Binds werden aus Home-Manager nach ~/.config/hypr/hyprland.conf geschrieben.
- Nix-Quelle: modules/home/desktop/wayland/caelestia/default.nix
- Siehe auch: assets/niri-keybindings-cheatsheet.md

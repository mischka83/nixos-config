# nixos-config

Persoenliche NixOS-Flake-Konfiguration fuer Host `nixos-btw` (Lenovo Legion 16ACHG6, KDE Plasma, Home Manager).

## Ziele

- Reproduzierbare System- und User-Konfiguration mit Flakes
- Trennung von Host-, Core- und Optional-Modulen
- KDE Plasma declarativ ueber `plasma-manager`
- Optionale Features (z. B. Flatpak, NVIDIA-Profile, Secure Boot) gezielt ein-/ausschaltbar

## Repository-Aufbau

- `flake.nix`: Flake-Einstieg, Inputs und `nixosConfigurations`
- `hosts/nixos-btw/`: Host-spezifische Imports und Hardware-Config
- `modules/core/`: Basis-Module (Boot, Netzwerk, Nutzer, Services, Pakete, Desktop, Audio)
- `modules/optional/`: Optional aktivierbare Module (z. B. Flatpak, NVIDIA-Profile, Secure Boot)
- `home/mischka/`: Home-Manager-Konfiguration fuer User `mischka`
- `assets/`: Repositorieigene Assets (z. B. Wallpaper)

## Voraussetzungen

- NixOS mit aktivierten Flake-Features (`nix-command` und `flakes`)
- `sudo`-Rechte fuer System-Rebuilds

## Taegliche Befehle

### Konfiguration anwenden

```bash
sudo nixos-rebuild switch --flake ~/nixos-config#nixos-btw
```

### Inputs aktualisieren

```bash
cd ~/nixos-config
sudo nix flake update
sudo nixos-rebuild switch --flake .#nixos-btw
```

### Build nur testen (ohne Aktivierung)

```bash
cd ~/nixos-config
sudo nixos-rebuild build --flake .#nixos-btw
```

## Wichtige Hinweise

- Flake-Auswertung nutzt den Git-Snapshot. Neue Dateien muessen vor der Auswertung mit `git add` getrackt sein.
- Ein "dirty tree" ist nur eine Warnung, kein harter Abbruchgrund.
- Bei Paket-Build-Fehlern nach `flake update` ist oft ein Upstream-Problem in `nixpkgs` die Ursache.

## Optional-Module (Auswahl)

Aktivierung erfolgt ueber Imports in `hosts/nixos-btw/default.nix`.

- `modules/optional/flatpak.nix`: Flatpak systemweit aktivieren
- `modules/optional/nvidia-hybrid.nix`: AMD iGPU + NVIDIA Offload
- `modules/optional/nvidia-dgpu-only.nix`: NVIDIA als primaeres Rendering
- `modules/optional/secure-boot.nix`: Vorbereitung fuer Lanzaboote/Secure Boot
- `modules/optional/tpm2-luks.nix`: TPM2/LUKS-Integration

## Home-Manager / Plasma

- User-Konfiguration: `home/mischka/default.nix`
- KDE-Panel, Theme, Shortcuts etc.: `home/mischka/desktop/plasma/`
- Flatpak-User-Installationen (z. B. RDM, Teams): `home/mischka/programs/flatpak.nix`

## Git-Workflow (empfohlen)

```bash
cd ~/nixos-config
git checkout -b feature/mein-change
# Dateien aendern
git add <dateien>
git commit -m "feat: ..."
sudo nixos-rebuild build --flake .#nixos-btw
```

## Lizenz

Private Konfiguration, keine explizite Lizenz gesetzt.

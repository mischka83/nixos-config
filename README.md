# nixos-config

Persoenliche NixOS-Flake-Konfiguration fuer Host `nixos-btw` (Lenovo Legion 16ACHG6, KDE Plasma, Home Manager).

## Ziele

Status der Hauptziele:

- [x] Reproduzierbare System- und User-Konfiguration mit Flakes
- [x] Trennung von Host-, Core- und Optional-Modulen
- [x] KDE Plasma declarativ ueber `plasma-manager`
- [x] Optionale Features (z. B. Flatpak, NVIDIA-Profile, Secure Boot) gezielt ein-/ausschaltbar

Offene Punkte / naechste Schritte:

- [ ] DMS-Verhalten zwischen KDE und Niri im Alltag weiter verifizieren (kein unbeabsichtigter KDE-Start)
- [ ] Optional-Module weiter in der README mit kurzen "wann aktivieren"-Hinweisen dokumentieren

## Repository-Aufbau

- `flake.nix`: Flake-Einstieg, Inputs und `nixosConfigurations`
- `hosts/nixos-btw/`: Host-spezifische Imports und Hardware-Config
- `modules/core/`: Basis-Module (Boot, Netzwerk, Nutzer, Services, Pakete, Desktop, Audio)
- `modules/optional/`: Optional aktivierbare Module (z. B. Flatpak, NVIDIA-Profile, Secure Boot)
- `home/mischka/`: User-spezifische Home-Manager-Komposition fuer `mischka`
- `modules/home/`: Wiederverwendbare Home-Manager-Module (Programs, Shell, Desktop)
- `assets/`: Repositorieigene Assets (z. B. Cheatsheets, Profilbild)

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
- `modules/optional/disable-usb-wakeup.nix`: USB-Wakeup fuer bestimmte USB-Geraete abschalten
- `modules/optional/niri-dms.nix`: Niri-Session + DankMaterialShell-Voraussetzungen parallel zu Plasma
- `modules/optional/nvidia-hybrid.nix`: AMD iGPU + NVIDIA Offload
- `modules/optional/nvidia-dgpu-only.nix`: NVIDIA als primaeres Rendering
- `modules/optional/rdm-fhs.nix`: Devolutions Remote Desktop Manager als FHS-Testpaket
- `modules/optional/secure-boot.nix`: Vorbereitung fuer Lanzaboote/Secure Boot
- `modules/optional/tpm2-luks.nix`: TPM2/LUKS-Integration

## TPM2/LUKS Betrieb

- Re-Enroll ist normalerweise **nicht** bei regulaeren Rebuilds noetig.
- Typischer Trigger fuer Re-Enroll: Firmware-/Secure-Boot-Aenderungen oder TPM-Reset.
- Helper-Kommando (aus `modules/optional/tpm2-luks.nix`):

```bash
sudo reenroll-luks-tpm2
```

## Test-Checkliste: DMS nur in Niri

Nach Aenderungen an `modules/home/desktop/niri.nix`:

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#nixos-btw
```

Manuelle Session-Tests:

1. In KDE Plasma anmelden.
2. In einem Terminal pruefen, dass DMS nicht laeuft:

```bash
systemctl --user status dms.service --no-pager
```

Erwartung: Dienst ist `inactive` oder `exited` und startet nicht als laufende Shell.

3. Abmelden und in Niri anmelden.
4. Erneut pruefen:

```bash
systemctl --user status dms.service --no-pager
```

Erwartung: Dienst ist `active (running)`.

5. Nochmals nach KDE zurueckwechseln und Schritt 2 wiederholen, um Session-Leaks auszuschliessen.

## Home-Manager / Plasma

- User-Konfiguration: `home/mischka/default.nix`
- Wiederverwendbare Home-Module: `modules/home/default.nix`
- KDE-Panel, Theme, Shortcuts etc.: `modules/home/desktop/plasma/`
- Flatpak-User-Installationen (z. B. RDM, Teams): `modules/home/programs/flatpak.nix`

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

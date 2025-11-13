{ config, pkgs, lib, ... }:

{
  services.flatpak.enable = true;

  system.activationScripts.installFlatpaks.text = ''
    echo "Installing Flatpaks..."
    ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    for app in com.github.tchx84.Flatseal \
               io.github.flattool.Warehouse \
               it.mijorus.gearlever \
               com.devolutions.remotedesktopmanager \
               org.DolphinEmu.dolphin-emu \
               com.rtosta.zapzap \
               org.filezillaproject.Filezilla \
               org.ppsspp.PPSSPP; do \
      ${pkgs.flatpak}/bin/flatpak install -y flathub "$app" || true
    done
  '';

  # Flatpak Applications-List
    # io.github.freedoom.Phase1 # Freedoom Phase 1
    # io.github.freedoom.Phase2 # Freedoom Phase 2
    # com.brave.Browser # Brave Browser
}

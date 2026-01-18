{ config, pkgs, lib, ... }:

{
  ##############################################
  # 🔹 Virtualisierung - Core-Defaults
  ##############################################
  # Alles deaktiviert, nur Standardwerte
  virtualisation = {
    docker.enable = false;
    libvirtd.enable = false;
    virtualbox.host.enable = false;
  };

  # vboxusers Gruppe wird nur auf Hosts aktiviert, die VBox nutzen
  users.extraGroups.vboxusers.members = [];
}

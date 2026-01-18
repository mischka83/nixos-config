{ config, pkgs, lib, ... }:

{
  ##############################################
  # 🔹 Virtualisierung - Core Defaults
  ##############################################

  virtualisation = {
    docker.enable = lib.mkDefault false;
    libvirtd.enable = lib.mkDefault false;
    virtualbox.host.enable = lib.mkDefault false;
  };

  # Gruppe nur vorbereiten, Hosts füllen sie
  users.extraGroups.vboxusers.members = lib.mkDefault [];
}

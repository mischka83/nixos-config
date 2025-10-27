{ inputs, config, pkgs, ... }:

{
  # ✅ NetworkManager aktivieren
  networking = {
    networkmanager.enable = true;
  };
}
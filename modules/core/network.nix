{ inputs, config, pkgs, ... }:

{
  # ✅ NetworkManager aktivieren
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect
    ];
  };
}
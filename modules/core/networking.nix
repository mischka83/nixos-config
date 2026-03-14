{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  # OpenConnect VPN Plugin für Cisco AnyConnect Kompatibilität
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openconnect
  ];

  # OpenConnect CLI Tool
  environment.systemPackages = with pkgs; [
    openconnect
  ];
}

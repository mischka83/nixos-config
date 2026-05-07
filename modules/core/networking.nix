{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  # OpenConnect VPN Plugin für Cisco AnyConnect Kompatibilität
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openconnect
    networkmanager-l2tp
  ];

  # OpenConnect CLI Tool
  environment.systemPackages = with pkgs; [
    openconnect
  ];

  # NM-L2TP schreibt Laufzeit-Secrets nach /etc/ipsec.d
  systemd.tmpfiles.rules = [
    "d /etc/ipsec.d 0755 root root -"
    "d /etc/ipsec.d/private 0700 root root -"
  ];

  # Workaround fuer bekannten NM-L2TP/strongSwan Bug:
  # /etc/strongswan.conf muss vorhanden sein, auch wenn sie leer ist.
  environment.etc."strongswan.conf".text = "";
}

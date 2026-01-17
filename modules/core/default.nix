{ config, pkgs, ... }:

{
imports = [
    ./auto-upgrade.nix
    ./boot.nix
    ./virtualisation.nix
    ./flatpak.nix
    ./fonts.nix
    ./hardware.nix
    ./network.nix
    ./packages.nix
    ./sddm.nix
    ./security.nix
    ./services.nix
    ./system.nix
    ./users.nix
    ./xserver.nix
  ];

}
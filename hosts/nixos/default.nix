{ config, pkgs, ... }:

{
  ##############################################
  # 🧩 Imports (Modular)
  ##############################################
  imports = [
    ../../modules/core
    ./hardware.nix
    ./host-packages.nix
  ];

  networking.hostName = "nixos";

  services.printing.enable = true;
  
  my.gc = {
    enable = true;
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  ##############################################
  # 🔄 Auto Upgrade (flake based)
  ##############################################
  my.autoUpgrade = {
    enable = false;
    host = "nixos";
  };
}

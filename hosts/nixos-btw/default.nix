{ config, pkgs, inputs, ... }:

{
  ##############################################
  # 🧩 Imports (Modular)
  ##############################################
  imports = [
    ../../modules/core
    ./hardware.nix
    ./host-packages.nix
  ];

  networking.hostName = "nixos-btw";

  ##############################################
  # ⚙️ Nix & System Maintenance
  ##############################################
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 20d";
  };

  nix.optimise.automatic = true;

  ##############################################
  # 🔄 Auto Upgrade (flake based)
  ##############################################
  my.autoUpgrade = {
    enable = true;
    host = "nixos-btw";
    # flakePath = "/home/mischka/nixos-config"; # optional override
  };
}

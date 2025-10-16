{ config, pkgs, inputs, ... }:

{
  ##############################################
  # 🧩 Imports (Modular)
  ##############################################
  imports = [
    ../../hardware-configuration.nix
    ./i18n.nix
    ./hardware.nix
    ./desktop.nix
    ./audio.nix
    ./packages.nix
    ./users.nix
  ];

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

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    flake = "/home/mischka/nixos-config#nixos-btw";
    dates = "daily";
  };

  # Systemd Timer / Service für Auto-Upgrade
  systemd.services."nixos-auto-upgrade" = {
    description = "Automatic daily NixOS upgrade via flakes";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        /run/current-system/sw/bin/nix flake update /home/mischka/nixos-config
        /run/current-system/sw/bin/nixos-rebuild switch --flake /home/mischka/nixos-config#nixos-btw
      '';
      StandardOutput = "journal";
      StandardError = "journal";
    };
  };

  systemd.timers."nixos-auto-upgrade" = {
    description = "Run nixos-auto-upgrade daily";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };

  ##############################################
  # 🧩 System Version
  ##############################################
  system.stateVersion = "25.05";
}

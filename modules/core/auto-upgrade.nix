{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.my.autoUpgrade;
in
{
  options.my.autoUpgrade = {
    enable = mkEnableOption "Automatic flake-based NixOS upgrades";

    flakePath = mkOption {
      type = types.str;
      default = "/home/mischka/nixos-config";
      description = "Path to NixOS flake repo.";
    };

    host = mkOption {
      type = types.str;
      description = "Flake host name.";
    };
  };

  config = mkIf cfg.enable {

    systemd.services.nixos-auto-upgrade = {
      description = "Automatic NixOS upgrade via flakes";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          ${pkgs.nix}/bin/nix flake update --commit-lock-file ${cfg.flakePath}
          /run/current-system/sw/bin/nixos-rebuild switch --flake ${cfg.flakePath}#${cfg.host}
        '';
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };

    systemd.timers.nixos-auto-upgrade = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        RandomizedDelaySec = "1h";
        OnBootSec = "10min";
        WakeSystem = true;
      };
    };
  };
}

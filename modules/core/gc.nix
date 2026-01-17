{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.my.gc;
in
{
  options.my.gc = {
    enable = mkEnableOption "Enable automatic garbage collection";

    automatic = mkOption {
      type = types.bool;
      default = true;
      description = "Enable automatic garbage collection";
    };

    dates = mkOption {
      type = types.str;
      default = "weekly";
      description = "Cron-like schedule for automatic GC";
    };

    options = mkOption {
      type = types.str;
      default = "--delete-older-than 20d";
      description = "Extra options for nix-collect-garbage";
    };
  };

  config = mkIf cfg.enable {
    nix.gc = {
      automatic = cfg.automatic;
      dates = cfg.dates;
      options = cfg.options;
    };
  };
}

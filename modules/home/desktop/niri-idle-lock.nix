{ lib, config, pkgs, ... }:

let
  cfg = config.profile.desktop.niri;
in
{
  config = lib.mkIf cfg.enable {
    services.swayidle = {
      enable = true;
      systemdTarget = "niri.service";
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          event = "lock";
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
      ];
      timeouts = [
        {
          timeout = 600;
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
      ];
    };
  };
}

{ config, pkgs, ... }:
{
    security = {
      rtkit.enable = true; # RealtimeKit for low-latency audio
    };
}
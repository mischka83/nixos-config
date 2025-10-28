{ config, pkgs, ... }:

{

  services = {
    desktopManager.plasma6.enable = true;
    # Firmware & SSD
    fwupd.enable = true;
    fstrim.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true; # moderner Session-Manager
    };
    pulseaudio.enable = false;
  };
  




}

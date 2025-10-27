{ config, pkgs, ... }:

{

  services = {
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

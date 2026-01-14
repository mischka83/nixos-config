{ config, pkgs, lib, ... }:

{

  services.flatpak = {
    enable = true;
    packages = [
      "com.discordapp.Discord"
      "org.filezillaproject.Filezilla"
      "com.rtosta.zapzap"
      # "org.DolphinEmu.dolphin-emu"
      "com.devolutions.remotedesktopmanager"
      "it.mijorus.gearlever"
      "io.github.flattool.Warehouse"
      "com.github.tchx84.Flatseal"
      # "org.ppsspp.PPSSPP"
      "io.github.freedoom.Phase1"
      "io.github.freedoom.Phase2"
      # "com.brave.Browser"
    ];
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };

}

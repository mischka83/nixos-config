{ pkgs, ... }:

{
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extest.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    mangohud
  ];
}
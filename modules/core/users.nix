{ config, pkgs, ... }:

{
  users.users.mischka = {
    isNormalUser = true;
    description = "Christian Ewert";
    extraGroups = [ "networkmanager" "wheel" ];

    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}
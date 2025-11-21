{ config, pkgs, ... }:

{

  users.users.mischka = {
    isNormalUser = true;
    description = "Christian Ewert";
    extraGroups = [ "networkmanager" "wheel" "docker" ]; # 'wheel' = sudo-Rechte
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
}

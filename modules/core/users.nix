{ config, pkgs, ... }:

{
  # Enable Zsh shell system-wide
  programs.zsh.enable = true;

  users.users.mischka = {
    isNormalUser = true;
    description = "Christian Ewert";
    extraGroups = [ "networkmanager" "wheel" "i2c" "video" ];

    # Set Zsh as default shell
    shell = pkgs.zsh;

    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}

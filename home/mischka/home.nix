{ config, pkgs, ... }:

{
  home.username = "mischka";
  home.homeDirectory = "/home/mischka";

  programs.git = {
    enable = true;
    userName = "Christian Ewert";
    userEmail = "CEwert@gmx.net";
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "z" ];
    };
  };

  home.packages = with pkgs; [
    htop
    bat
    neofetch
  ];

  home.stateVersion = "25.05"; # Wichtig! Entspricht NixOS Version
}

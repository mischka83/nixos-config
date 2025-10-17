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
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      ll = "ls -alh";
      gs = "git status";
    };

    history = {
      size = 10000;
      save = true;
    };

    promptInit = ''
      autoload -Uz promptinit
      promptinit
      prompt pure
    '';
  };



  home.packages = with pkgs; [
    htop
    bat
    neofetch
  ];

  home.stateVersion = "25.05"; # Wichtig! Entspricht NixOS Version
}

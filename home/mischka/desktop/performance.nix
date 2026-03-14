{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.kde-cli-tools
  ];

  programs.plasma.kwin = {
    effects = {
      minimizeAnimation = false;
      maximizeAnimation = false;
    };
  };
}

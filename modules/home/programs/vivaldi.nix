{ config, ... }:

{
  programs.vivaldi = {
    enable = config.mischka.browser == "vivaldi";
  };
}

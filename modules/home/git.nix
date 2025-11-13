{ config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Christian Ewert";
    userEmail = "CEwert@gmx.net";
  };
}

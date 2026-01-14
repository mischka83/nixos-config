{ config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.emailuser = "Christian Ewert";
      user.nameuser = "CEwert@gmx.net";
    };
  };
}

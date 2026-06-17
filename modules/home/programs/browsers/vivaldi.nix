{ config, ... }:

{
  programs.vivaldi = {
    enable = builtins.elem "vivaldi" config.profile.browsers;
    commandLineArgs = [
      "--password-store=gnome-libsecret"
    ];
  };
}

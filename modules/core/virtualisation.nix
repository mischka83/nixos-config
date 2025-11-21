{ config, pkgs, lib, ... }:

{
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    virtualbox.host.enable = true;
  };
  users.extraGroups.vboxusers.members = [ "mischka" ];


}
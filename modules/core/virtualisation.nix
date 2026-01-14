{ config, pkgs, lib, ... }:

{
  virtualisation = {
    docker.enable = false;
    libvirtd.enable = false;
    virtualbox.host.enable = true;
    virtualbox.host.enableKvm = true;
    virtualbox.host.addNetworkInterface = false;
  };
  users.extraGroups.vboxusers.members = [ "mischka" ];


}
{ config, pkgs, lib, ... }:

{
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };


}
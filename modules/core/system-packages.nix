{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    zed-editor
    sbctl
    efibootmgr
  ];
}

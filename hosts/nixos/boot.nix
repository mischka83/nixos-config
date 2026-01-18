{ config, pkgs, ... }:

{
  ##############################################
  # 🖥 Desktop – Simple iGPU Setup
  ##############################################

  boot.kernelParams = [
    "quiet"
    "loglevel=3"
  ];
}

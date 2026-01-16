{ config, pkgs, ... }:

let
  kernelVersion = "6.17.12";
  linuxSrc = pkgs.fetchurl {
    url = "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${kernelVersion}.tar.xz";
    sha256 = "QngElvmRlOnWayHxPcK97ZUmJNXHvYPq3n90/2WOmNY="; # korrekter Hash
  };

  customLinux = pkgs.linuxPackagesFor (pkgs.linux_6_17.override {
    argsOverride = rec {
      src = linuxSrc;
      version = kernelVersion;
      modDirVersion = kernelVersion;
    };
  });
in

{
  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_6_12; # LTS Kernel
    # kernelPackages = customLinux;

    kernelParams = [
      "amdgpu.dc=1"
      "amdgpu.runpm=0"
      "amdgpu.aspm=0"
    ];

    #loader options
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
}

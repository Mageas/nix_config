{ config, lib, pkgs, modulesPath, nixos-hardware, ... }:

# TODO(jakehamilton): Phase most of this out when nixos-hardware
# is updated with Framework support.
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelModules = [ "kvm-amd" ];

    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "virtio_pci" "sr_mod" "virtio_blk" ]; # AFTER sd_mod
      kernelModules = [ ];
    };

    extraModulePackages = [ ];
  };
  
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
 };
  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}

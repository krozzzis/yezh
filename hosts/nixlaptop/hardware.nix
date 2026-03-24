{ delib, config, lib, modulesPath, ... }:
delib.host {
  name = "nixlaptop";

  system = "x86_64-linux";

  nixos = {
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/aff407fc-9e82-421f-a234-ec9eb88212dc";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/3E48-CE46";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    fileSystems."/home/krozzzis" =
      { device = "/dev/disk/by-uuid/154a91d6-d3fa-4a6c-82a4-437432cbf026";
        fsType = "btrfs";
      };

    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 12*1024;
      }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

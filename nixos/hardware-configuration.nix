# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config
, lib
, pkgs
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware = {
    bluetooth.enable = true;
    nvidia = {
      # Modesetting is needed for most Wayland compositors
      modesetting.enable = true;
      # # Use the open source version of the kernel module
      # # Only available on driver 515.43.04+
      open = false;
      #
      powerManagement.enable = true;
      # # Enable the nvidia settings menu
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      driSupport = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
        (intel-vaapi-driver.override { enableHybridCodec = true; })
      ];
    };
  };
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1a866cee-45a8-498a-86a9-aa7616443435";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/82C0-CB92";
    fsType = "vfat";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0f1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;
  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 4200 4201 4202 80 443 ];
    allowedUDPPorts = [ 4200 8088 ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

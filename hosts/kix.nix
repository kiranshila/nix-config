# Configuration for my main home desktop, Kix
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Various hardware tweaks
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-hidpi

    # Import the generated hardware configuration
    # Filesystem, initd, etc.
    ../hardware/kix.nix
  ];

  # Set the default session to X11 because NVIDIA
  services.displayManager.defaultSession = "plasmax11";
  services.displayManager.sddm = {
    wayland.enable = false;
  };

  # Setup NVIDIA drivers
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Custom boot settings
  boot = {
    # Enable IOMMU for libvirt and isolate the gpu we'll pass through
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "vfio-pci.ids=10de:1c31,10de:10f1"
    ];

    # VFIO kernel modules
    initrd.kernelModules = [
      # Explicitly load VFIO before nvidia so the driver doesn't grab control before vfio
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"

      #      "nvidia"
      #      "nvidia_uvm"
      #    "nvidia_drm"
    ];
  };

  # NixOS "State Version"
  system.stateVersion = "24.05";
}

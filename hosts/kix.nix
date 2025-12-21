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

    # Import the generated hardware configuration
    # Filesystem, initd, etc.
    ../hardware/kix.nix
  ];

  services.displayManager.sddm = {
    wayland.enable = true;
  };

  # Setup NVIDIA drivers
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };

  # Custom boot settings
  boot = {
    # Enable IOMMU for libvirt and isolate the gpu we'll pass through
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "pci=routeirq" # Force IRQ rerouting
    ];

    # VFIO kernel modules
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];

    # These must be baked into the initrd image, kernel params pick them up too lake because nvidia
    # Add Quadro, its audio, and the firewire controller (both the TI PCI controller and the PCIe to PCI bridge chip on the same card)
    extraModprobeConfig = ''
      softdep nvidia pre: vfio-pci
      softdep firewire_ohci pre: vfio-pci
      options vfio_iommu_type1 allow_unsafe_interrupts=1
      options vfio-pci ids=10de:1c31,10de:10f1,104c:8024,1b21:1080
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

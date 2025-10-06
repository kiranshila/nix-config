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

  # Set the default session to X11 because NVIDIA
  services.displayManager.defaultSession = "plasmax11";
  services.displayManager.sddm = {
    wayland.enable = false;
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
    ];

    # VFIO kernel modules
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];

    # These must be baked into the initrd image, kernel params pick them up too lake because nvidia
    extraModprobeConfig = ''
      softdep nvidia pre: vfio-pci
      options vfio-pci ids=10de:1c31,10de:10f1
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

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
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # NixOS "State Version"
  system.stateVersion = "24.05";
}

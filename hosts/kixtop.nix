# Configuration for my 11th gen Framework 13 Laptop
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Framework Laptop 11th Gen Intel
    inputs.hardware.nixosModules.framework-11th-gen-intel

    # Import the generated hardware configuration
    # Filesystem, initd, etc.
    ../hardware/kixtop.nix
  ];

  # Enable SDDM Wayland
  services.displayManager.sddm = {
    wayland.enable = true;
  };

  # Install HP Printer Drivers
  services.printing.drivers = [
    pkgs.hplip
  ];

  # Configure syncthing here until
  # https://github.com/nix-community/home-manager/issues/4049
  # gets fixed
  services.syncthing = {
    enable = true;
    user = "kiran";
    dataDir = "/home/kiran/sync";
    configDir = "/home/kiran/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "Work" = {id = "SLZVNXV-SVWL2PN-H7JFQBN-UVH33AK-HPZDKGO-QMJ3SNM-TEKCANG-SXN7DQM";};
        "Home" = {id = "HVJWGBC-Q5YPP5V-XHM7XHL-M3DGVX7-SSGQVQQ-KKA7BLS-HYRXQDC-II3QSQ4";};
        "NAS" = {id = "PQRDY3U-HFLWGDI-B5KSHL2-ICXC6SM-WYPGZZ5-F553F3T-ZCYPSUR-STUJ5A4";};
      };
      folders = {
        "apybf-p3tmn" = {
          path = "/home/kiran/sync";
          devices = ["NAS" "Home" "Work"];
        };
      };
    };
  };

  # NixOS "State Version"
  system.stateVersion = "23.11";
}

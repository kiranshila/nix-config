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

  # VPN
  networking = {
    wg-quick.interfaces = {
      wg0 = {
        # Determines the IP/IPv6 address and subnet of the client's end of the tunnel interface
        address = ["10.10.10.3/24"];
        dns = ["10.10.10.1"];
        # The port that WireGuard listens to - recommended that this be changed from default
        listenPort = 51820;
        # Path to the server's private key
        privateKeyFile = "/home/kiran/sync/Keys/wireguard/kixtop_private";
        # Point to server
        peers = [
          {
            publicKey = "ir9VitpGaipQ3183crPzbI0D4JTNR+lKZmuv2CnG51U=";
            allowedIPs = ["0.0.0.0/0" "::/0"];
            endpoint = "vpn.kiranshila.com:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };

  # NixOS "State Version"
  system.stateVersion = "23.11";
}

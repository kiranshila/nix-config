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

  # VPN
  networking.wg-quick.interfaces = {
    wg0 = {
      autostart = false;
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

  # NixOS "State Version"
  system.stateVersion = "23.11";
}

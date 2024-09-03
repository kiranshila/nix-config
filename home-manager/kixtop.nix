{pkgs, ...}: {
  imports = [./common.nix];

  # Enable syncthing tray
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  # Setup pass
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "/home/kiran/sync/.password-store";
    };
  };

  # Use the pgtk build as kixtop is on wayland
  programs.emacs.package = pkgs.emacs-gtk;
  # VPN
  networking = {
    firewall = {
      allowedUDPPorts = [51820];
    };
    wireguard.interfaces = {
      wg0 = {
        ips = ["10.10.10.3/24"];
        listenPort = 51820;
        privateKeyFile = "/home/kiran/sync/wireguard/kixtop_private";
        peers = [
          {
            publicKey = "ir9VitpGaipQ3183crPzbI0D4JTNR+lKZmuv2CnG51U=";
            allowedIPs = ["0.0.0.0/0"];
            endpoint = "vpn.kiranshila.com:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };

  # NixOS State Version for Home
  home.stateVersion = "23.11";
}

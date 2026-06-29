{
  pkgs,
  lib,
  ...
}: let
  syncDevices = import ./modules/services/syncthing-devices.nix;
  # Share the ~/sync folder with the named devices.
  syncWith = names: {
    devices = lib.genAttrs names (name: {id = syncDevices.${name};});
    folders."apybf-p3tmn".devices = names;
  };
in {
  imports = [./modules];

  # Set my home directory
  home = {
    username = "kiran";
    homeDirectory = "/home/kiran";
  };

  # Sync to Home, Work, and NAS
  services.syncthing.settings = syncWith ["NAS" "Home" "Work"];

  # Kixtop-specific packages
  home.packages = with pkgs; [
    protonup-qt
  ];

  # NixOS State Version for Home
  home.stateVersion = "23.11";
}

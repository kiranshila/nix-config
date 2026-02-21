{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./common.nix
    ./common/openrct2.nix
  ];

  # Set my home directory
  home = {
    username = "kiran";
    homeDirectory = "/home/kiran";
  };

  # Setup pass
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "/home/kiran/sync/.password-store";
    };
  };

  # Sync to Work, Laptop, and NAS
  services.syncthing.settings = {
    devices = {
      "Work" = {id = "XCYWCRK-ERH6M6W-2O2IZ2J-XGBDYC4-7AQFG5J-PFYB43U-JNRN7MU-JZVBFAG";};
      "NAS" = {id = "PQRDY3U-HFLWGDI-B5KSHL2-ICXC6SM-WYPGZZ5-F553F3T-ZCYPSUR-STUJ5A4";};
      "Laptop" = {id = "5YNXHAA-3O3C4DV-L23BD6P-R3XMQ73-5YBKUFP-5IQRGQ7-XKTCMLH-UVITPQG";};
    };
    folders = {
      "apybf-p3tmn" = {
        path = "/home/kiran/sync";
        devices = ["NAS" "Laptop" "Work"];
      };
    };
  };

  # Kix-specific packages
  home.packages = with pkgs; [
    protonup-qt
    via
  ];


  # NixOS State Version for Home
  home.stateVersion = "25.05";
}

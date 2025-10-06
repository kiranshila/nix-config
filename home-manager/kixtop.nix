{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [./common.nix];

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

  # Sync to home and NAS
  services.syncthing.settings = {
    devices = {
      "Work" = {id = "XCYWCRK-ERH6M6W-2O2IZ2J-XGBDYC4-7AQFG5J-PFYB43U-JNRN7MU-JZVBFAG";};
      "Home" = {id = "FD3VE6H-PABFAI2-KFJTYBN-WDJ4WRZ-XGOSAFB-6IYPQ45-4CJ2NOW-LZB6NA2";};
      "NAS" = {id = "PQRDY3U-HFLWGDI-B5KSHL2-ICXC6SM-WYPGZZ5-F553F3T-ZCYPSUR-STUJ5A4";};
    };
    folders = {
      "apybf-p3tmn" = {
        path = "/home/kiran/sync";
        devices = ["NAS" "Home" "Work"];
      };
    };
  };

  # Kixtop-specific packages
  home.packages = lib.mkMerge [
    (with pkgs; [
      protonup-qt
      pkgs.discord
    ])
  ];

  # NixOS State Version for Home
  home.stateVersion = "23.11";
}

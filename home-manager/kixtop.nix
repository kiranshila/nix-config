{pkgs, ...}: {
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

  # Use the pgtk build as kixtop is on wayland
  programs.emacs.package = pkgs.emacs-gtk;

  # Sync to home and NAS
  services.syncthing.settings = {
    devices = {
      "Work" = {id = "XCYWCRK-ERH6M6W-2O2IZ2J-XGBDYC4-7AQFG5J-PFYB43U-JNRN7MU-JZVBFAG";};
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

  # NixOS State Version for Home
  home.stateVersion = "23.11";
}

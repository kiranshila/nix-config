{...}: {
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

  # NixOS State Version for Home
  home.stateVersion = "23.11";
}

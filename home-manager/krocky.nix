{
  pkgs,
  config,
  nixgl,
  ...
}: {
  # Setup NixGL
  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "nvidia";
  nixGL.installScripts = ["nvidia"];

  imports = [./common.nix];

  # Set my home directory
  home = {
    username = "kshila";
    homeDirectory = "/home/kshila";
  };

  # Enable syncthing tray
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  # Use the pgtk build as kixtop is on wayland
  programs.emacs.package = config.lib.nixGL.wrap pkgs.emacs-gtk;

  # Setup bash to just launch fish
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # NixOS State Version for Home
  home.stateVersion = "25.05";
}

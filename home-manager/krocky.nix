{
  pkgs,
  config,
  nixgl,
  lib,
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

  # Rocky uses gnome, so switch the pinentry (and wrap with nixgl)
  services.gpg-agent.pinentry.package = config.lib.nixGL.wrap pkgs.pinentry-gnome3;

  # We have to handle the SSH_AUTH_SOCK manually
  programs.fish.interactiveShellInit = lib.mkAfter ''
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
  '';

  # Add syncthing config to sync to home, laptop, and NAS
  services.syncthing.settings = {
    devices = {
      "Laptop" = {id = "5YNXHAA-3O3C4DV-L23BD6P-R3XMQ73-5YBKUFP-5IQRGQ7-XKTCMLH-UVITPQG";};
      "Home" = {id = "HVJWGBC-Q5YPP5V-XHM7XHL-M3DGVX7-SSGQVQQ-KKA7BLS-HYRXQDC-II3QSQ4";};
      "NAS" = {id = "PQRDY3U-HFLWGDI-B5KSHL2-ICXC6SM-WYPGZZ5-F553F3T-ZCYPSUR-STUJ5A4";};
    };
    folders = {
      "apybf-p3tmn" = {
        path = "/home/kshila/sync";
        devices = ["NAS" "Home" "Laptop"];
      };
    };
  };

  # NixOS State Version for Home
  home.stateVersion = "25.05";
}

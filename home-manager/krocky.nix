{
  pkgs,
  config,
  nixgl,
  lib,
  ...
}: {
  # Setup NixGL
  targets.genericLinux.nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "nvidia";
    installScripts = ["nvidia"];
  };

  imports = [./common.nix];

  # Set my home directory
  home = {
    username = "kshila";
    homeDirectory = "/home/kshila";
  };

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
      "Laptop" = {
        id = "5YNXHAA-3O3C4DV-L23BD6P-R3XMQ73-5YBKUFP-5IQRGQ7-XKTCMLH-UVITPQG";
      };
      "Home" = {
        id = "FD3VE6H-PABFAI2-KFJTYBN-WDJ4WRZ-XGOSAFB-6IYPQ45-4CJ2NOW-LZB6NA2";
      };
      "NAS" = {
        id = "PQRDY3U-HFLWGDI-B5KSHL2-ICXC6SM-WYPGZZ5-F553F3T-ZCYPSUR-STUJ5A4";
      };
    };
    folders = {
      "apybf-p3tmn" = {
        path = "/home/kshila/sync";
        devices = [
          "NAS"
          "Home"
          "Laptop"
        ];
      };
    };
  };

  # Enable just work email on work machine
  accounts.email.accounts = {
    "me@kiranshila.com" = {
      primary = false;
      thunderbird.enable = false;
    };
    "kshila@caltech.edu" = {
      primary = true;
    };
  };

  # Emacs to nixgl-ed non-wayland
  programs.doom-emacs.emacs = config.lib.nixGL.wrap pkgs.emacs;

  # NixOS State Version for Home
  home.stateVersion = "25.05";
}

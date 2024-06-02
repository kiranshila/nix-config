# Base OS Configuration
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
    ./hardware-configuration.nix

    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  # Configure the bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 10;
  };

  # Set the interpreter for AppImages
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  # Setup networking
  networking = {
    hostName = "kixtop";
    networkmanager.enable = true;
    # Syncthing ports:
    # 22000 TCP and/or UDP for sync traffic
    # 21027/UDP for discovery
    # source: https://docs.syncthing.net/users/firewall.html
    firewall.allowedTCPPorts = [22000];
    firewall.allowedUDPPorts = [22000 21027];
  };

  # Setup time
  time.timeZone = "America/Los_Angeles";

  # Locale Chaos
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # KDE Setup
  services.desktopManager = {
    plasma6.enable = true;
  };

  # X Server Setup (KDE Plasma and SDDM)
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Printing
  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplip
    ];
  };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Linux <3 Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Security
  security.rtkit.enable = true;

  nixpkgs = {
    # Setup the overlays
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
    # Configure your nixpkgs instance to allow unfree
    # Sorry, RMS
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
    # Allow me to specify additional substituters
    trusted-users = ["kiran"];
    # List of substituters
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Systemwide user settings
  users.users = {
    kiran = {
      isNormalUser = true;
      description = "Kiran Shila";
      extraGroups = ["wheel" "networkmanager" "dialout"];
    };
  };

  # Launch fish unless the parent process is fish (keeping bash as system shell)
  # This gets around a bug with fish not being quite posix
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # Enable completions
  programs.fish.enable = true;

  # Setup home manager
  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      # Import your home-manager configuration
      kiran = import ../home-manager/home.nix;
    };
    # Packages installed to /etc/profiles
    useUserPackages = true;
    # Use the global pkgs configured with the system
    useGlobalPkgs = true;
  };

  # Fundamental system packages
  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git
    wget
    curl
    vim
  ];

  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

  # Make dirty binaries "just work"
  programs.nix-ld.enable = true;

  # Configure syncthing here until
  # https://github.com/nix-community/home-manager/issues/4049
  # gets fixed
  services.syncthing = {
    enable = true;
    user = "kiran";
    dataDir = "/home/kiran/sync";
    configDir = "/home/kiran/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "Work" = {id = "SLZVNXV-SVWL2PN-H7JFQBN-UVH33AK-HPZDKGO-QMJ3SNM-TEKCANG-SXN7DQM";};
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
  };

  # Enable hardware support for yubikey/smartcards
  services.pcscd.enable = true;
  hardware.gpgSmartcards.enable = true;

  # Enable steam
  # NOTE: This is system-level because of how steam needs 32-bit binaries,
  # which must be installed systemwide
  programs.steam.enable = true;

  # Enable Xbox One controller drivers
  hardware.xone.enable = true;

  # Udev rules for USB things like tigard
  services.udev.extraRules = ''
      # FT232AM/FT232BM/FT232R
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6001", GROUP="dialout", MODE="0664"
    # FT2232C/FT2232D/FT2232H
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", GROUP="dialout", MODE="0664"
    # FT4232/FT4232H
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6011", GROUP="dialout", MODE="0664"
    # FT232H
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6014", GROUP="dialout", MODE="0664"
    # FT230X/FT231X/FT234X
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6015", GROUP="dialout", MODE="0664"
    # FT4232HA
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6048", GROUP="dialout", MODE="0664"
  '';

  # NixOS "State Version"
  system.stateVersion = "23.11";
}

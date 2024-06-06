# Common NixOS system config to be inherited by all systems
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Bring in home manager
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

  # Setup networking and syncthing ports
  networking = {
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

  # X Server Setup (KDE Plasma and SDDM)
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Use SDDM
  services.displayManager.sddm = {
    enable = true;
  };

  # Use KDE Plasma 6
  services.desktopManager = {
    plasma6.enable = true;
  };

  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Linux <3 Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Nixpkgs Configuration
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

  # Kiran is always the default user
  users.users = {
    kiran = {
      isNormalUser = true;
      description = "Kiran Shila";
      extraGroups = ["wheel" "networkmanager" "dialout" "libvirtd"];
    };
  };

  # Security
  security.rtkit.enable = true;

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

  # Some barebones programs everyone needs
  environment.systemPackages = with pkgs; [
    wget
    curl
    vim
    alejandra
  ];

  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

  # Make dirty binaries "just work"
  programs.nix-ld.enable = true;

  # Enable hardware support for yubikey/smartcards
  services.pcscd.enable = true;
  hardware.gpgSmartcards.enable = true;

  # Enable steam
  # NOTE: This is system-level because of how steam needs 32-bit binaries,
  # which must be installed systemwide
  programs.steam.enable = true;

  # Enable Xbox One controller drivers
  hardware.xone.enable = true;

  # Enable partition manager (needs dbus, so system-leve)
  programs.partition-manager.enable = true;

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

  # Try to mount NFS store
  fileSystems."/mnt/storage" = {
    device = "192.168.4.202:/volume1/storage";
    fsType = "nfs";
    options = ["nfsvers=4.1" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  # Virtualization
  virtualisation = {
    # spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      # qemu = {
      #   package = pkgs.qemu_kvm;
      #   runAsRoot = true;
      #   swtpm.enable = true;
      #   ovmf = {
      #     enable = true;
      #     packages = [
      #       (pkgs.OVMF.override {
      #         secureBoot = true;
      #         tpmSupport = true;
      #       })
      #       .fd
      #     ];
      #   };
      # };
    };
  };
  programs.virt-manager.enable = true;
}

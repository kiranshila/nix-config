{
  description = "Kiran's NixOS Config";

  # Sources for all nix flakes that make up the config
  inputs = {
    # NixPkgs unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware Definitions
    hardware.url = "github:NixOS/nixos-hardware";

    # NixGL
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Determinate Nix
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    # Doom Emacs
    nix-doom = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository
    nur = {
      url = "github:nix-community/NUR";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    # Catppuccin Everything
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hardware,
    nixgl,
    determinate,
    nix-doom,
    nur,
    catppuccin,
    ...
  } @ inputs: let
    inherit (self) outputs;

    homeModules = [
      nix-doom.homeModule
      catppuccin.homeModules.catppuccin
    ];

    nixosModules = [
      determinate.nixosModules.default
      catppuccin.nixosModules.catppuccin
    ];

    overlays = [
      nixgl.overlay
      nur.overlays.default
    ];

    # A function to automatically set the hostname and hostname-derived config
    commonModules = name:
      [
        ./hosts/common.nix
        {networking.hostName = name;}
        {nixpkgs.overlays = overlays;}
        {
          home-manager = {
            # Just pass the whole input output sets to HM
            extraSpecialArgs = {inherit inputs outputs nixgl;};
            useUserPackages = true;
            useGlobalPkgs = true;
            backupFileExtension = "backup";
            sharedModules = homeModules;
            users = {
              kiran = import ./home-manager/${name}.nix;
            };
          };
        }
        ./hosts/${name}.nix
      ]
      ++ nixosModules;

    # A function to create the NixOS systems
    mkSystem = name: cfg:
      nixpkgs.lib.nixosSystem {
        system = cfg.system or "x86_64-linux";
        modules = (commonModules name) ++ (cfg.modules or []);
        specialArgs = {inherit inputs outputs;};
      };

    # The systems we'll configure
    systems = {
      # My home desktop
      kix = {};
      # My framework laptop
      kixtop = {};
    };
  in {
    # Build the systems for NixOS
    nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem systems;

    # Provide the home configuration for non-nixOS work machine
    homeConfigurations."kshila" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = overlays;
      };

      # The home-config for the standalone install
      modules =
        [
          ./home-manager/krocky.nix
        ]
        ++ homeModules;

      # Passing along nixgl to the standalone
      extraSpecialArgs = {
        inherit nixgl;
      };
    };
  };
}

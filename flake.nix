{
  description = "Kiran's NixOS Config";

  # Sources for all nix flakes that make up the config
  inputs = {
    # NixPkgs unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware Definitions
    hardware.url = "github:NixOS/nixos-hardware";

    # Nix vscode extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # NixGL
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hardware,
    nix-vscode-extensions,
    nixgl,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # A function to automatically set the hostname and hostname-derived config
    commonModules = name: [
      ./hosts/common.nix
      {networking.hostName = name;}
      {
        home-manager = {
          # Just pass the whole input output sets to HM
          extraSpecialArgs = {inherit inputs outputs nixgl;};
          useUserPackages = true;
          useGlobalPkgs = true;
          users = {
            kiran = import ./home-manager/${name}.nix;
          };
        };
      }
      ./hosts/${name}.nix
    ];

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
        overlays = [
          nix-vscode-extensions.overlays.default
          nixgl.overlay
        ];
      };

      # The home-config for the standalone install
      modules = [./home-manager/krocky.nix];

      # Passing along nixgl to the standalone
      extraSpecialArgs = {
        inherit nixgl;
      };
    };
  };
}

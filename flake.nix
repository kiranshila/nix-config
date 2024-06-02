{
  description = "Kiran's NixOS Config";

  # Sources for all nix flakes that make up the config
  inputs = {
    # NixPkgs unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware Definitions
    hardware.url = "github:NixOS/nixos-hardware";

    # Nix vscode extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hardware,
    nix-vscode-extensions,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # A function to automatically set the hostname and hostname-derived config
    commonModules = name: [
      ./hosts/base.nix
      {networking.hostName = name;}
      {
        home-manager = {
          extraSpecialArgs = {inherit inputs outputs;};
          useUserPackages = true;
          useGlobalPkgs = true;
          users = {
            kiran = import ./home-manager/${name}.nix;
          };
        };
      }
      ./hosts/${name}.nix
    ];

    # A function to create the NixOS sytem
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
    # Build the systems
    nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem systems;
  };
}

{
  description = "Kiran's NixOS Config";
  inputs = {
    # NixPkgs, stable and unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware Definitions
    hardware.url = "github:NixOS/nixos-hardware/master";

    # Plasma Manager
    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    # Nix vscode extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    hardware,
    plasma-manager,
    nix-vscode-extensions,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # NixOS configuration entrypoint
    # Available through `nixos-rebuild --flake .#hostname`
    nixosConfigurations.kixtop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Pass flake inputs to our config
      specialArgs = {inherit inputs outputs;};
      modules = [
        # Our main nixos config file
        ./nixos/configuration.nix
      ];
    };
  };
}

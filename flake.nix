{
  description = "Kiran's NixOS Config";
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

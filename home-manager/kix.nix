{...}: {
  imports = [
    ./common.nix
  ];

  # Set my home directory
  home = {
    username = "kiran";
    homeDirectory = "/home/kiran";
  };

  # NixOS State Version for Home
  home.stateVersion = "24.05";
}

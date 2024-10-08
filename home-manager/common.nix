# Common home-manager settings
{...}: {
  # Set my home directory
  home = {
    username = "kiran";
    homeDirectory = "/home/kiran";
  };

  # Enable fontconfig
  fonts.fontconfig.enable = true;

  # Enable home-manager, the program
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Enable nix-index
  programs.nix-index.enable = true;

  # Enable Direnv
  programs.direnv.enable = true;

  # Enable atuin
  programs.atuin.enable = true;

  # Bring in everything else
  imports = [
    ./common/emacs.nix
    ./common/email.nix
    ./common/firefox.nix
    ./common/fish.nix
    ./common/git.nix
    ./common/gpg.nix
    ./common/pkgs.nix
    ./common/ssh.nix
    ./common/vscode.nix
  ];
}

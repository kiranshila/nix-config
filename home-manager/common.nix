# Common home-manager settings
{
  config,
  pkgs,
  ...
}: {
  # Enable fontconfig
  fonts.fontconfig.enable = true;

  # Enable home-manager, the program
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Enable nix-index
  programs.nix-index.enable = true;

  # Enable Direnv using nix-direnv (faster than use_fale)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Enable atuin
  # On new deployments, run `atuin login -u kiranshila`
  # Then run atuin import auto; atuin sync;
  programs.atuin = {
    enable = true;
    settings = {
      sync_frequency = "5m";
    };
  };

  # Firefox
  programs.firefox = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.firefox;
  };

  # Bring in everything else that might need more configuration
  imports = [
    ./common/emacs.nix
    ./common/email.nix
    ./common/fish.nix
    ./common/git.nix
    ./common/gpg.nix
    ./common/kitty.nix
    ./common/pkgs.nix
    ./common/ssh.nix
    ./common/syncthing.nix
    ./common/vscode.nix
    ./common/helix.nix
  ];
}

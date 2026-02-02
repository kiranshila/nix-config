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

  # Enable Direnv using nix-direnv (faster than use_flake)
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

  # Enable the local-component to browserpass
  # The extension still seems like it needs to be enabled manually
  programs.browserpass = {
    enable = true;
    browsers = ["firefox"];
  };

  # cat replacement
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      # batgrep # currently broken
      batwatch
    ];
  };

  # ls replacement
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  # Very good fuzzy finder
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  # Catppuccin Theme
  # This will configure the following programs (if managed with home-manager)
  # - atuin
  # - bat
  # - eza
  # - firefox
  # - fish
  # - fzf
  # - helix
  # - kitty
  # - starship
  # - thunderbird
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    thunderbird.profile = "default";
    firefox.enable = false;
  };

  # Minecraft
  home.packages = with pkgs; [
    (prismlauncher.override {
      additionalPrograms = [ffmpeg]; # Some mods need it
    })
  ];

  # Bring in everything else that might need more configuration
  imports = [
    ./common/calendar.nix
    ./common/emacs.nix
    ./common/email.nix
    ./common/firefox/firefox.nix
    ./common/fish.nix
    ./common/git.nix
    ./common/gpg.nix
    ./common/kitty.nix
    ./common/openscad.nix
    ./common/pkgs.nix
    ./common/ssh.nix
    ./common/syncthing.nix
    ./common/helix.nix
  ];
}

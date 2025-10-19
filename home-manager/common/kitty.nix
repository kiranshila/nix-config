# Kitty terminal config
{
  pkgs,
  config,
  ...
}:
{
  programs.kitty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.kitty;
    shellIntegration.enableFishIntegration = true;
    enableGitIntegration = true;
    font = {
      # Pkg providing font already in common/pkgs
      name = "Iosevka";
      size = 12;
    };
  };
}

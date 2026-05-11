{
  lib,
  config,
  pkgs,
  ...
}: let
  # NixGL wrap
  package = config.lib.nixGL.wrap pkgs.firefox;
  profile = "default";
  legacyPath = "${config.home.homeDirectory}/.mozilla/firefox";
in {
  warnings = lib.mkIf (builtins.pathExists legacyPath) [
    "Firefox: legacy profile directory '${legacyPath}' still exists. Move it to '${config.xdg.configHome}/mozilla/firefox' and remove the old directory."
  ];
  home.sessionVariables = {
    DEFAULT_BROWSER = package;
    BROWSER = package;
  };

  programs.firefox = {
    inherit package;
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    policies = import ./policies.nix;
    profiles.${profile} = import ./profile.nix {inherit lib pkgs config;};
  };
}

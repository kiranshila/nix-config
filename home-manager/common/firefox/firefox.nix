{
  lib,
  config,
  pkgs,
  ...
}: let
  # NixGL wrap
  package = config.lib.nixGL.wrap pkgs.firefox;
  profile = "default";
in {
  home.sessionVariables = {
    DEFAULT_BROWSER = package;
    BROWSER = package;
  };

  programs.firefox = {
    inherit package;
    enable = true;
    policies = import ./policies.nix;
    profiles.${profile} = import ./profile.nix {inherit lib pkgs config;};
  };
}

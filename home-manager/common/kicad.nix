{
  config,
  pkgs,
  ...
}: let
  # myKicad = pkgs.kicad.override {
  #   srcs = {
  #     kicad = pkgs.fetchFromGitLab {
  #       owner = "kiranshila";
  #       repo = "kicad";
  #       rev = "9.0-big-iters";
  #       hash = "sha256-sAkzHB71ojkrZao9TfL+ekx4w5FHIg3GTRwMekXmJtA=";
  #     };
  #     kicadVersion = "9.0-big-iters";
  #   };
  #   stable = false;
  # };
  myKicad = pkgs.kicad;
in {
  home.packages = [
    (config.lib.nixGL.wrap
      (myKicad.overrideAttrs (oldAttrs: {
        makeWrapperArgs =
          oldAttrs.makeWrapperArgs
          ++ [
            "--set-default KICAD_DSA_LIBRARY /home/kshila/sync/Projects/PCB/dsa2klib"
          ];
      })))
  ];
}

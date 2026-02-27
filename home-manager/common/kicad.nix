{
  config,
  pkgs,
  ...
}: let
  # no 3d moodels to save the nix store
  # Use non-compressed 3d models for step export
  myKicad = pkgs.kicad-small.override {
    compressStep = false;
  };
in {
  home.packages = [
    (config.lib.nixGL.wrap
      (myKicad.overrideAttrs (oldAttrs: {
        makeWrapperArgs =
          oldAttrs.makeWrapperArgs
          ++ [
            "--set-default KICAD_DSA_LIBRARY /home/kshila/sync/Projects/PCB/dsa2klib"
            "--set-default KICAD9_3DMODEL_DIR /home/kshila/.local/share/kicad/kicad-packages3D"
          ];
      })))
  ];
}

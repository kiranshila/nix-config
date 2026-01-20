{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    (pkgs.kicad.overrideAttrs (oldAttrs: {
      makeWrapperArgs =
        oldAttrs.makeWrapperArgs
        ++ [
          "--set-default KICAD_DSA_LIBRARY /home/kshila/sync/Projects/PCB/dsa2klib"
        ];
    }))
  ];
}

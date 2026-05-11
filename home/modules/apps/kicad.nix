{
  config,
  pkgs,
  ...
}:
let
  myKicad = pkgs.kicad-testing;
in
{
  home.packages = [
    (config.lib.nixGL.wrap (
      myKicad.overrideAttrs (oldAttrs: {
        makeWrapperArgs = oldAttrs.makeWrapperArgs ++ [
          "--set-default KICAD_DSA_LIBRARY ${config.home.homeDirectory}/sync/Projects/PCB/dsa2klib"
        ];
      })
    ))
  ];
}

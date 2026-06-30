# nixGL-wrapped GUI applications and non-wrapped GUI apps
{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs;
    map config.lib.nixGL.wrap [
      onlyoffice-desktopeditors
      slack
      musescore
      muse-sounds-manager
      zotero
      obsidian
      qucs-s
      paraview
      cockatrice
      remmina
      prusa-slicer
      veracrypt
      qtpass
      element-desktop
      signal-desktop
      zoom-us
    ];
}

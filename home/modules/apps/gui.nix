# nixGL-wrapped GUI applications and non-wrapped GUI apps
{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs;
    map config.lib.nixGL.wrap [
      onlyoffice-desktopeditors
      looking-glass-client
      slack
      zulip
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
    ];
}

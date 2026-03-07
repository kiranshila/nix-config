# nixGL-wrapped GUI applications and non-wrapped GUI apps
{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    (config.lib.nixGL.wrap onlyoffice-desktopeditors)
    (config.lib.nixGL.wrap looking-glass-client)
    (config.lib.nixGL.wrap slack)
    (config.lib.nixGL.wrap zulip)
    (config.lib.nixGL.wrap musescore)
    (config.lib.nixGL.wrap muse-sounds-manager)
    (config.lib.nixGL.wrap zotero)
    (config.lib.nixGL.wrap obsidian)
    (config.lib.nixGL.wrap qucs-s)
    (config.lib.nixGL.wrap paraview)
    (config.lib.nixGL.wrap cockatrice)
    (config.lib.nixGL.wrap remmina)
    prusa-slicer
    veracrypt
    qtpass
  ];
}

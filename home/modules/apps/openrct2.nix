{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [openrct2];
  home.file.".config/OpenRCT2/config.ini".text = lib.generators.toINI {} {
    general = {
      game_path = "/mnt/hdd/SteamLibrary/steamapps/common/Rollercoaster Tycoon 2/";
    };
  };
}

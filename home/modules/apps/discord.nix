{config, ...}: {
  programs.nixcord = {
    enable = true;
    user = config.home.username;
    homeDirectory = config.home.homeDirectory;

    discord = {
      vencord.enable = false;
      equicord.enable = true;
      krisp.enable = true;
      installPackage = false; # Below, wraps nixGL
    };

    config = {
      plugins = {
        betterFolders.enable = true;
        loginWithQr.enable = true;
      };
    };
  };

  # Wrap the final assembled package with nixGL
  home.packages = [
    (config.lib.nixGL.wrap config.programs.nixcord.finalPackage.discord)
  ];
}

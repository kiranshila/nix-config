# Syncthing file sharing
{config, ...}: {
  services.syncthing = {
    enable = true;
    # Every host shares the same ~/sync folder; only the device list differs.
    settings.folders."apybf-p3tmn".path = "${config.home.homeDirectory}/sync";
  };
}

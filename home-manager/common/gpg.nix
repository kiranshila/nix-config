{pkgs, ...}: {
  # Configure gpg
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
    };
    mutableKeys = false;
    mutableTrust = true;
    # Import my public key and give it ultimate trust
    publicKeys = [
      {
        source = ../../assets/publickey.gpg;
        trust = "ultimate";
      }
    ];
  };

  # Setup GPG Agent
  # Following Dr. Duh
  # https://raw.githubusercontent.com/drduh/config/master/gpg-agent.conf
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    pinentry.package = pkgs.pinentry-qt;
  };
}

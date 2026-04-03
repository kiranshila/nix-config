{
  pkgs,
  lib,
  ...
}: {
  # Configure gpg
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = false; # Don't use PCSC at all, only use smart card with GPG
    };
    # Import my public key and give it ultimate trust
    publicKeys = [
      {
        source = ../../../assets/publickey.gpg;
        trust = "ultimate";
      }
    ];

    # From Dr Duh
    settings = {
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      fixed-list-mode = true;
      no-comments = true;
      no-emit-version = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      with-fingerprint = true;
      require-cross-certification = true;
      no-symkey-cache = true;
      use-agent = true;
      throw-keyids = true;
      # Prevent gpg from auto-launching a daemon agent. home-manager's
      # publicKeys activation runs in a system service before the user
      # systemd session is ready, which would otherwise spawn a second
      # gpg-agent daemon that conflicts with the socket-activated one.
      no-autostart = true;
    };
  };

  # Setup GPG Agent
  # Following Dr. Duh
  # https://raw.githubusercontent.com/drduh/config/master/gpg-agent.conf
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    # Set a default, but allow for overrides
    # pinentry-qt on KDE Wayland fails to register with the XDG portal
    # (no .desktop file for org.gnupg.pinentry-qt), causing PIN dialogs to
    # never appear and hanging all GPG/smartcard operations.
    # pinentry-gnome3 handles Wayland natively and works correctly on KDE.
    pinentry.package = lib.mkDefault pkgs.pinentry-gnome3;
    enableScDaemon = true;
    extraConfig = ''
      ttyname $GPG_TTY
    '';
  };
}

# SSH Config
{...}: {
  # Copy in the yubikey ssh public key to use as an explicit identity
  # This is ok to live in the nix store because, public key
  # Normally you'd not do this for a private key
  home.file.".ssh/id_rsa_yubikey.pub" = {
    source = ../../assets/id_rsa_yubikey.pub;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identitiesOnly = true;
        identityFile = "~/.ssh/id_rsa_yubikey.pub";
      };

      "ovro" = {
        hostname = "ssh.ovro.caltech.edu";
        user = "kiran";
      };

      "grex" = {
        hostname = "grex-ovro.ovro.pvt";
        proxyJump = "ovro";
        user = "user";
      };

      "github.com" = {
        user = "git";
      };

      "sprite" = {
        user = "sprite";
        hostname = "turtle.ovro.pvt";
        proxyJump = "ovro";
      };

      "mvp03" = {
        user = "kshila";
        hostname = "mvp03mncopl.ovro.pvt";
        proxyJump = "ovro";
      };
    };
  };
}

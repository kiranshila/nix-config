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
    matchBlocks = {
      "*" = {
        identitiesOnly = true;
        identityFile = "~/.ssh/id_rsa_yubikey.pub";
      };

      "grex" = {
        hostname = "grex.ovro.pvt";
        proxyJump = "ssh.ovro.caltech.edu";
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
    };
  };
}

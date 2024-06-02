# SSH Config
{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "grex" = {
        hostname = "grex.ovro.pvt";
        proxyJump = "ssh.ovro.caltech.edu";
        user = "user";
      };
    };
  };
}

{pkgs, ...}: {
  # Helix Editor
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language-server.texlab.config.texlab.build = {
        onSave = true;
        executable = "${pkgs.texlab}/bin/texlab";
      };
    };
  };
}

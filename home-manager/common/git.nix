# Git config
{...}: {
  programs.git = {
    enable = true;
    userName = "Kiran Shila";
    userEmail = "me@kiranshila.com";
    lfs.enable = true;
    difftastic.enable = true;
    signing = {
      key = null;
      signByDefault = false;
    };
    extraConfig = {
      init = {defaultBranch = "main";};
      pull = {rebase = true;};
    };
  };
}

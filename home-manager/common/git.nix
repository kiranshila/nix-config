# Git config
{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      key = null;
      signByDefault = true;
    };
    settings = {
      user = {
        email = "me@kiranshila.com";
        name = "Kiran Shila";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
    };
  };

  # Enable difftastic (for git)
  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

}

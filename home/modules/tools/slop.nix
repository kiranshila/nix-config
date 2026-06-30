{pkgs, ...}: {
  programs.opencode = {
    enable = true;
    package = pkgs.llm-agents.opencode;
  };
}

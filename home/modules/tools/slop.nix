{pkgs, ...}: {
  # hermes-agent — persistent memory assistant (Nous Research)
  # TODO: replace with programs.hermes-agent once PR #9087 merges
  home.packages = [pkgs.llm-agents.hermes-agent];
}

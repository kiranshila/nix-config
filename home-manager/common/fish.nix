# Fish Shell
{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "bang-bang";
        src = pkgs.fishPlugins.bang-bang.src;
      }
    ];
    shellAliases = {
      ls = "eza";
      cat = "bat";
      hms = "home-manager switch --impure";
      wg-up = "sudo systemctl start wg-quick-wg0.service";
      wg-down = "sudo systemctl stop wg-quick-wg0.service";
    };
  };

  # Use starship as the prompt
  programs.starship = {
    enable = true;
  };
}

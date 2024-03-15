{ pkgs
, config
, lib
, ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.fzf.enableFishIntegration = true;
  programs.starship.enableFishIntegration = true;
}

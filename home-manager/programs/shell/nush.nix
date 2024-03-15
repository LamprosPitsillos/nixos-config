{ pkgs
, config
, lib
, ...
}: {
  programs.nushell = {
    enable = true;
  };

  # programs.fzf.enableFishIntegration = true;
  # programs.starship.enableFishIntegration = true;
}

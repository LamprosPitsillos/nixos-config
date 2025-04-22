{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
        window-decoration = false;
        gtk-single-instance = true;
    };
  };
}

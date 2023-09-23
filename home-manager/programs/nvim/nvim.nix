{inputs,pkgs,...}:{

    xdg.configFile."nvim" = {
      source = ./.;
      recursive = true;
    };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    vimAlias = true;
    viAlias = true;
    extraPackages = with pkgs; [gcc ripgrep fd nodejs_18];
  };
    }

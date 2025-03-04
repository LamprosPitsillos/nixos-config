{ inputs
, pkgs
, ...
}: {
  xdg.configFile."nvim" = {
    source = ./.;
    recursive = true;
  };
  programs.neovim =
    let
      neovim-nightly = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    in
    {
      enable = true;
      defaultEditor = true;
      package = neovim-nightly;

      withPython3 = true;
      withNodeJs = true;
      # package = pkgs.neovim-unwrapped;

      vimAlias = true;
      viAlias = true;

      extraPackages = with pkgs; [

        luajitPackages.luarocks
        lua51Packages.lua

        websocat

        ripgrep
        fd
        gcc
        gnumake


        gdb

        # LSPs
        # clang-tools_17
        # clang-tools
        phpactor
        omnisharp-roslyn
        cmake-language-server
        lua-language-server
        marksman
        nil
        nodePackages_latest."@prisma/language-server"
        nodePackages_latest."@tailwindcss/language-server"
        nodePackages_latest.bash-language-server
        nodePackages_latest.svelte-language-server
        nodePackages_latest.typescript-language-server
        vue-language-server
        nodePackages_latest.vscode-langservers-extracted
        python311Packages.pylsp-rope
        # python311Packages.python-lsp-ruff
        python311Packages.python-lsp-server
        quick-lint-js
        dot-language-server
        rust-analyzer
        typescript
        # typst-lsp
        tinymist
        typstfmt
        typstyle
        zls
      ];
    };
}

{ lib
, config
, pkgs
# , inputs
, ...
}: {
  imports = [
    ./programs/starship/starship.nix
    ./programs/shell/fish.nix
    ./programs/file_manager/yazi.nix
    ./programs/vcs/git.nix
    ./programs/terminal/tmux.nix
    ./programs/nvim/nvim.nix
  ];

  nixpkgs.overlays = [
    (final: prev: { nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" "Lekton" "Mononoki" ]; }; })
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dev-wsl";
  home.homeDirectory = "/home/dev-wsl";
  home.shellAliases =
  let
     eza = lib.getExe pkgs.eza ;
  in {
    nup = "sudo nixos-rebuild switch --flake /home/inferno/.nixos-config#nixosWSL && notify-send 'NixOs' 'System rebuilt'";
    nupb = "sudo nixos-rebuild boot --flake /home/inferno/.nixos-config#nixosWSL";
    hup = "home-manager switch -b backup -I nixpkgs=flake:nixpkgs --flake /home/inferno/.nixos-config\#dev-wsl && notify-send 'NixOs' 'HomeManager rebuilt'";
    nconf = "nv /home/inferno/.nixos-config/nixos/wsl-configuration.nix";
    hconf = "nv /home/inferno/.nixos-config/home-manager/wsl.nix";

    ls = "${eza} --icons --git";
    ll = "${eza} --icons --git --long";
    la = "${eza} --icons --git --long --accessed --all";
    lar = "${eza} --icons --git --long --accessed --all --tree --level";
    tree = "${eza} --icons --tree --accessed";
    nv = "nvim";
    q = "exit";
    se = "sudoedit";
    ".." = "cd ..";
    "..." = "cd ../../";
    "...." = "cd ../../../";

    # GIT
    gco = "git checkout";
    gcl = "git clone";
    gdf = "git diff";
    gst = "git status";
    # Network
    nmqr = "nmcli dev wifi show-password";
    theme = ''wallust theme $(wallust theme --help | rg "possible values:" | sed -e "s/.*possible values:\(.*\)]/\1/" | tr , "\n" |fzf)'';
  };


  programs.bat = {
    enable = true;
    config = {
      theme = "OneHalfDark";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true; # see note on other shells below
    # options = [
    #   "--cmd"
    #   "cd"
    # ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };


  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    defaultOptions = [
      "--height 40%"
      "--border"
    ];

    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d --max-depth 2";
    changeDirWidgetOptions = [ "--preview '${pkgs.eza}/bin/eza --icons --tree --accessed {} | head -200'" ];
    tmux.enableShellIntegration = true;
  };

  # xdg.configFile."neovide/config.toml" = {
  #   enable = true;
  #   text = /* toml */ ''
  #     wsl = false
  #     no-multigrid = false
  #     vsync = true
  #     maximized = false
  #     srgb = false
  #     idle = true
  #     neovim-bin = "/usr/bin/env nvim" # in reality found dynamically on $PATH if unset
  #     frame = "full"
  #   '';
  #
  # };

  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

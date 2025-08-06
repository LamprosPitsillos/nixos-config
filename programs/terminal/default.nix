{ ... }:
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
    ./ghostty.nix
    ./wezterm.nix

    ./shell

    ./multiplexer/tmux.nix
  ];
}

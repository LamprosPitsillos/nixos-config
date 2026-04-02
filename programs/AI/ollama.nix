{ pkgs, ... }:
{
  services.ollama = {
    enable = false;
    package = pkgs.ollama-cuda;
  };
}

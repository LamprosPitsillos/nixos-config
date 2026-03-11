{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  name = "paperless";
  port = toString config.services.${name}.port;
  url = "http://local.${name}.com";
in
{

  services.paperless = {
    enable = true;
    settings = {
      PAPERLESS_URL = "${url}";
      PAPERLESS_CONSUMER_IGNORE_PATTERN = [
        ".DS_STORE/*"
        "desktop.ini"
      ];
      PAPERLESS_OCR_LANGUAGE = "ell+eng";
      PAPERLESS_OCR_USER_ARGS = {
        optimize = 1;
        pdfa_image_compression = "lossless";
      };
    };
  };

  services.caddy.virtualHosts."${url}" = {
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${port}
    '';
  };
}

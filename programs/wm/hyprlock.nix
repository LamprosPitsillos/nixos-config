{ pkgs, lib, osConfig, ... }:
{
  programs.hyprlock = {
    enable = !osConfig.custom.hostProps.isHeadless;
    settings =
      let
        font = "JetBrainsMono NF";
      in
      {
        animations = {
          enabled = false;
        };

        general = {
          hide_cursor = false;
          immediate_render = true;
          screencopy_mode = 1;
        };

        background = {
          monitor = "";
          color = "rgba(0,0,0,1)";
        };

        label = [
          {
            monitor = "";
            text = "$TIME12";
            font_family = font;
            color = "rgba(200,200,200,1)";
            font_size = 100;

            halign = "center";
            valign = "center";
            position = " 0 ,200 ";
          }

          {
            monitor = "";
            text = "cmd[update:10000] date";
            font_family = font;
            font_size = 16;
            color = "rgba(180,180,180,1)";
            position = " 0 ,-10 ";

            halign = "right";
            valign = "top";
          }

          {
            monitor = "";
            text = "cmd[update:10000] ${lib.getExe pkgs.acpi}" ;
            font_family = font;
            font_size = 16;
            color = "rgba(180,180,180,1)";
            position = " 0 ,-10 ";

            halign = "left";
            valign = "top";
          }
          {

            monitor = "";
            text = "Attempts: $ATTEMPTS";
            font_family = font;
            font_size = 18;
            color = "rgba(200,200,200,1)";

            halign = "center";
            valign = "center";
            position = " 0 ,-60 ";
          }
        ];
        shape = {
          monitor = "";
          size = " 520, 260 ";
          halign = "center";
          valign = "center";
          rounding = 0;

          color = "rgba(0,0,0,0.45)";
          border_size = 3;
          border_color = "rgba(200,200,200,0.85)";
        };

        input-field = {
          monitor = "";
          size = " 180 , 36 ";
          halign = "center";
          valign = "center";
          position = " -10, 48 ";

          font_family = font;
          font_color = "rgba(200,200,200,1)";
          inner_color = "rgba(0,0,0,0)";
          outer_color = "rgba(0,0,0,0)";
          outline_thickness = 0;
          rounding = 0;

          dots_text_format = "╌";
          dots_size = 2;
          dots_spacing = 0;
          fade_on_empty = false;
          placeholder_text = "-*-";
        };
      };
  };
}

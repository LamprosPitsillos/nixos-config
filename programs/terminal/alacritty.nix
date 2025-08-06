{ pkgs, ... }: {
  programs.alacritty = let font_family = "JetBrainsMono NF"; in {
    enable = false;
    settings = {
        font = {

            normal = {family = font_family ; style= "Regular";};
            bold = {family = font_family ; style= "Bold";};
            italic = {family = font_family ; style= "Italic";};
            bold_italic = {family = font_family ; style= "Bold Italic";};
            size= 14;

            };
    };
  };
}

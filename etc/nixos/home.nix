{ config, pkgs, inputs, ... }:

{
home.username = "kvarnitz";
home.homeDirectory = "/home/kvarnitz";
home.stateVersion = "25.05";

  home.file.".local/share/fonts" = {
    source = "${inputs.my-nixos-repo}/home/kvarnitz/.local/share/fonts";
    recursive = true;
  };
  home.file.".config/hypr/Wallpaper.jpg" = {
    source = "${inputs.my-nixos-repo}/home/kvarnitz/.config/hypr/Wallpaper.jpg";
  };

    # Для шрифтиків
    FREETYPE_PROPERTIES = "truetype:interpreter-version=38";
  };

}

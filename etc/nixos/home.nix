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

fonts.fontconfig = {
  enable = true;
  defaultFonts = {
    serif = [ "Noto Serif" "Noto Color Emoji" ];
    sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
    monospace = [ "Nihonium113" "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
    emoji = [ "Noto Color Emoji" ];
  };
};

  home.sessionVariables = {
    # Для кращого рендерингу в Wayland
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";

    # Для шрифтиків
    FREETYPE_PROPERTIES = "truetype:interpreter-version=38";
  };

programs.kitty = {
  enable = true;
  font = {
    name = "Nihonium113";
    size = 12;
  };
};

}

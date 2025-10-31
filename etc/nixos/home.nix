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
    serif = [ "Nihonium113" "Noto Color Emoji" ];
    sansSerif = [ "Nihonium113" "Noto Color Emoji" ];
    monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
    emoji = [ "Noto Color Emoji" ];
  };
};

gtk = {
    enable = true;
    font = {
      name = "Nihonium113 Regular";
      size = 12;
    };
  };

}

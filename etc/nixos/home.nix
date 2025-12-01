{ config, pkgs, inputs, ... }:

{
home.username = "kvarnitz";
home.homeDirectory = "/home/kvarnitz";
home.stateVersion = "25.11";

  fonts.fontconfig = {
    enable = true;
  };

  home.file.".local/share/fonts" = {
    source = "${inputs.my-nixos-repo}/home/kvarnitz/.local/share/fonts";
    recursive = true;
  };
  home.file.".config/hypr/Wallpaper.jpg" = {
    source = "${inputs.my-nixos-repo}/home/kvarnitz/.config/hypr/Wallpaper.jpg";
  };

}

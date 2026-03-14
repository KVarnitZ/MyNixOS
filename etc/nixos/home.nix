{ config, pkgs, inputs, ... }:

{
  home.username = "kvarnitz";
  home.homeDirectory = "/home/kvarnitz";
  home.stateVersion = "25.11";
  wayland.windowManager.hyprland = {
    enable = true;
    settings.exec-once = [
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland"
      "systemctl --user start graphical-session.target"
    ];
  };

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

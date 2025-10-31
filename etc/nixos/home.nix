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

home.file.".config/fontconfig/fonts.conf".text = ''
  <?xml version="1.0"?>
  <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  <fontconfig>
    <!-- Глобальні налаштування рендерингу -->
    <match target="font">
      <edit name="antialias" mode="assign">
        <bool>true</bool>
      </edit>
      <edit name="hinting" mode="assign">
        <bool>true</bool>
      </edit>
      <edit name="hintstyle" mode="assign">
        <const>hintfull</const>
      </edit>
      <edit name="rgba" mode="assign">
        <const>rgb</const>
      </edit>
      <edit name="lcdfilter" mode="assign">
        <const>lcddefault</const>
      </edit>
      <edit name="embeddedbitmap" mode="assign">
        <bool>false</bool>
      </edit>
    </match>

    <!-- Спеціально для Nihonium113 -->
    <match target="font">
      <test name="family" compare="eq">
        <string>Nihonium113</string>
      </test>
      <edit name="autohint" mode="assign">
        <bool>false</bool>
      </edit>
      <edit name="hinting" mode="assign">
        <bool>true</bool>
      </edit>
      <edit name="hintstyle" mode="assign">
        <const>hintfull</const>
      </edit>
    </match>

    <!-- Пріоритети -->
    <alias>
      <family>sans-serif</family>
      <prefer>
        <family>Nihonium113</family>
        <family>Noto Sans</family>
      </prefer>
    </alias>
    <alias>
      <family>serif</family>
      <prefer>
        <family>Nihonium113</family>
        <family>Noto Serif</family>
      </prefer>
    </alias>
  </fontconfig>
'';

fonts.fontconfig = {
  enable = true;
  defaultFonts = {
    serif = [ "Nihonium113" "Noto Color Emoji" ];
    sansSerif = [ "Nihonium113" "Noto Color Emoji" ];
    monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
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

gtk = {
    enable = true;
    font = {
      name = "Nihonium113 Regular";
      size = 12;
    };
  };

}

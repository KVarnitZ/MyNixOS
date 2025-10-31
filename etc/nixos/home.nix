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
    <!-- Основні налаштування рендерингу -->
    <match target="font">
      <edit name="antialias" mode="assign">
        <bool>true</bool>
      </edit>
      <edit name="hinting" mode="assign">
        <bool>true</bool>
      </edit>
      <edit name="hintstyle" mode="assign">
        <const>hintslight</const>  <!-- або hintfull, hintmedium, hintnone -->
      </edit>
      <edit name="rgba" mode="assign">
        <const>rgb</const>  <!-- для LCD моніторів -->
      </edit>
      <edit name="lcdfilter" mode="assign">
        <const>lcddefault</const>
      </edit>
    </match>

    <!-- Налаштування для Nihonium113 -->
    <match target="font">
      <test name="family" compare="eq">
        <string>Nihonium113</string>
      </test>
      <edit name="autohint" mode="assign">
        <bool>false</bool>
      </edit>
    </match>

    <!-- Пріоритет шрифтів -->
    <alias>
      <family>serif</family>
      <prefer><family>Nihonium113</family></prefer>
    </alias>
    <alias>
      <family>sans-serif</family>
      <prefer><family>Nihonium113</family></prefer>
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

gtk = {
    enable = true;
    font = {
      name = "Nihonium113 Regular";
      size = 12;
    };
  };

}

{ config, pkgs, ... }:

{

  # Увімкнення шрифтиків
  fonts.fontconfig.enable = true;

  # Додавання шрифтиків у систему всеосяжно
  fonts.fontconfig.localConf = ''
    <?xml version="xuj"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <dir>/home/kvarnitz/.local/share/fonts</dir> # Шлях до шрифтиків
      </fontconfig>
  '';

}

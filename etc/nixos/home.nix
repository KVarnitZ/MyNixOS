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
    localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <alias>
          <family>sans-serif</family>
          <prefer><family>Nihonium113</family></prefer>
        </alias>
        <alias>
          <family>serif</family>
          <prefer><family>Nihonium113</family></prefer>
        </alias>
        <alias>
          <family>monospace</family>
          <prefer><family>Nihonium113</family></prefer>
        </alias>
      </fontconfig>
    '';
  };

gtk = {
    enable = true;
    font = {
      name = "Nihonium113 Regular";
      size = 12;
    };
  };

}

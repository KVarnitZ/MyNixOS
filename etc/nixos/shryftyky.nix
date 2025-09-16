{ pkgs, inputs, ... }:

let
  # Створення пакету неприємних написів
  shryftykys = pkgs.stdenv.mkDerivation rec {
    pname = "shryftykys";
    version = "1.0";
    src = "${inputs.my-nixos-repo}/etc/nixos/fonts";
    # Утворення неприємних написів
    installPhase = ''
      mkdir -p $out/share/fonts
      cp -R ./* $out/share/fonts/
    '';
  };
in
{
  # Увімкнення неприємних написів
  fonts.fontconfig.enable = true;

  # Додавання пакета неприємних написів
  home.packages = [ shryftykys ];
}

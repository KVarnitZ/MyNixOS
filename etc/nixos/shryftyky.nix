{ pkgs, inputs, ... }:

# Створення пакету неприємних написів
 pkgs.stdenv.mkDerivation rec {
   pname = "shryftykys";
   version = "1.0";
   src = "${inputs.my-nixos-repo}/home/kvarnitz/.local/share/fonts";
   installPhase = ''
     mkdir -p $out/share/fonts
     cp -R ./* $out/share/fonts/
   '';
 }

{ pkgs, inputs, ... }:

# Створення пакету неприємних написів
 pkgs.stdenv.mkDerivation rec {
   pname = "my-custom-fonts";
   version = "1.0";
   src = "${inputs.my-nixos-repo}/etc/nixos/fonts";
   installPhase = ''
     mkdir -p $out/share/fonts
     cp -R ./* $out/share/fonts/
   '';
 }

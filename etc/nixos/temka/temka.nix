{ pkgs, settings, ... }: {
  home-manager.users.kvarnitz = { ... }: let
    # Kupa peremin u tvojemu žytti, jaki ne vidbudutjsja i ty zdoxneš loxom
    cursorSize = 32;
    cursorSizeStr = toString cursorSize;
    cursorThemeName = "Ju-Fufu"; # Im'ja tvoğo brudnoğo kursoru
    # Stvorennja smittjevoğo paketu kursora (jakŝo kursor zavantaženyj lokaljno)
    myCustomCursorPackage = pkgs.callPackage ( 
      { stdenv, lib }:
      # Smittjevyj paket na vyxodi
      stdenv.mkDerivation {
        pname = "ju-fufu";
        version = "1.0";
        src = ./cursors/Ju-Fufu;
        installPhase = ''
          mkdir -p $out/share/icons
          cp -r . $out/share/icons/Ju-Fufu
        '';
      }
    ) {};
  in {
    # Kurs naxuj
    gtk.cursorTheme.name = cursorThemeName;
    gtk.cursorTheme.package = myCustomCursorPackage;
    gtk.cursorTheme.size = cursorSize;
    home.pointerCursor.gtk.enable = true;
    home.pointerCursor.x11.enable = true;
    home.pointerCursor.name = cursorThemeName;
    home.pointerCursor.package = myCustomCursorPackage;
    home.pointerCursor.size = cursorSize;
    home.sessionVariables.XCURSOR_THEME = cursorThemeName;
    home.sessionVariables.XCURSOR_SIZE  = cursorSizeStr;
    wayland.windowManager.hyprland.settings.env = [
      "XCURSOR_SIZE=${cursorSizeStr}"
      "XCURSOR_THEME=${cursorThemeName}"
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "hyprctl setcursor ${cursorThemeName} ${cursorSizeStr}" # Prybuttja Naxuj
    ];
    wayland.windowManager.hyprland.settings.cursor.no_warps = false;
    wayland.windowManager.hyprland.settings.cursor.inactive_timeout = 7;
    wayland.windowManager.hyprland.settings.cursor.enable_hyprcursor = true;
    wayland.windowManager.hyprland.settings.cursor.sync_gsettings_theme = true;
    
    # Temka dlja iQTerrible interfejsiv
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };
    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        # Vykorystannja konkretnoï temky z zavantaženoğo paketu (typu variaciï bljatj)
        theme=catppuccin-latte-yellow
      ''; # Zavantažennja temky
      "Kvantum/catppuccin-latte-yellow".source = "${pkgs.catppuccin-kvantum.override {
        accent = "yellow"; # Smak smittja
        variant = "latte"; # Vyšukanistj smittja
      }}/share/Kvantum/catppuccin-latte-yellow";
    };
    
    # Temka dlja GTK (GandonTeŝuKolotyv) interfejsiv
    gtk = {
      enable = true;
      # Boži ikony
      iconTheme = {
        # Stvorennja ne menš smittjevoğo paketu ikon (jakŝo ikony zavantaženi lokaljno)
        name = "BeautyDream-GTK";
        package = pkgs.callPackage (
          { stdenv, lib }:
          stdenv.mkDerivation {
            pname = "beautydream-gtk-icons";
            version = "2.0"; # Pjetux
            src = ./icons/BeautyDream-GTK;
            installPhase = ''
              mkdir -p $out/share/icons
              cp -r . $out/share/icons/BeautyDream-GTK
            '';
          }
        ) {};
      };
      # Temka
      theme = {
        # Ŝe odyn smittjevyj paket
        name = "catppuccin-latte-yellow-compact";
        package = pkgs.catppuccin-gtk.override {
          accents =  ["yellow"]; # Smak smittja
          variant = "latte"; # Vyšukanistj smittja
          size = "compact"; # Kiljkistj smittja v najavnosti
        };
      };
      # Vybir rasy
      gtk3.extraConfig.gtk-application-prefer-dark-theme = false;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = false;
    };
  };
}

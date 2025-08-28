{ pkgs, settings, ... }: {
  home-manager.users.kvarnitz = { ... }: let
    # Купа перемін у твоєму житті, які не відбудуться і ти здохнеш лохом
    cursorSize = 32;
    cursorSizeStr = toString cursorSize;
    cursorThemeName = "Eksistere-Kyrenia"; # Ім'я твого брудного курсору
    # Створення сміттєвого пакету курсора (якщо курсор завантажений локально)
    myCustomCursorPackage = pkgs.callPackage ( 
      { stdenv, lib }:
      stdenv.mkDerivation {
        pname = "eksistere-kyrenia"; # Назва сміттєвого пакету на виході
        version = "1.0"; # Пєтух
        src = /etc/nixos/temka/cursors/Eksistere-Kyrenia; # Шлях до курсу Нахуй (має бути конкретний)
        installPhase = ''
          mkdir -p $out/share/icons
          cp -r . $out/share/icons/Eksistere-Kyrenia # Дубль
        '';
      }
    ) {};
  in {
    # Курс Нахуй
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
      "hyprctl setcursor ${cursorThemeName} ${cursorSizeStr}" # Прибуття Нахуй
    ];
    wayland.windowManager.hyprland.settings.cursor.no_warps = false;
    wayland.windowManager.hyprland.settings.cursor.inactive_timeout = 7;
    wayland.windowManager.hyprland.settings.cursor.enable_hyprcursor = true;
    wayland.windowManager.hyprland.settings.cursor.sync_gsettings_theme = true;
    
    # Темка для iQTerrible інтерфейсів 
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };
    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=GraphiteNord # Використання конкретної темки з завантаженого пакету (типу варіації блять)
      ''; # Завантаження темки
      "Kvantum/GraphiteNord".source = "${pkgs.graphite-kde-theme}/share/Kvantum/GraphiteNord";
    };
    
    # Темка для ГТК (ГандонТещуКолотив) інтерфейсів
    gtk = {
      enable = true;
      # Божі ікони
      iconTheme = {
        name = "BeautyDream-GTK"; # Назва божих ікон (має співпадати з папкою або пакетом)
        # Створення не менш сміттєвого пакету ікон (якщо ікони завантажені локально)
        package = pkgs.callPackage (
          { stdenv, lib }:
          stdenv.mkDerivation {
            pname = "beautydream-gtk-icons"; # Назва не менш сміттєвого пакету на виході
            version = "2.0"; # Пєтух
            src = /etc/nixos/temka/icons/BeautyDream-GTK; (має бути конкретний шлях до ікон)
            installPhase = ''
              mkdir -p $out/share/icons
              cp -r . $out/share/icons/BeautyDream-GTK # Дубль
            '';
          }
        ) {};
      };
      # Темка
      theme = {
        name = "catppuccin-latte-pink-compact"; # Ще один сміттєвий пакет
        package = pkgs.catppuccin-gtk.override {
          accents =  ["pink"]; # Смак сміття
          variant = "latte"; # Вишуканість сміття
          size = "compact"; # Кількість сміття в наявності
        };
      };
      # Вибір раси
      gtk3.extraConfig.gtk-application-prefer-dark-theme = false;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = false;
    };
  };
}

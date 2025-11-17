{ config, pkgs, lib, unstable, ... }:

{
  imports = 
    [  
      ./hardware-configuration.nix
      ./server.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "KVarnitZ"; # Шо ти, голова?

  # Інтернат
  networking.networkmanager.enable = true;

  # Де я?
  time.timeZone = "Europe/Kyiv";

  # Мовне питання
  i18n.defaultLocale = "uk_UA.UTF-8"; # en_US.UTF-8

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Звук та екран
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Клавіши тикати X11
  services.xserver.xkb = {
    layout = "us,ua";
    variant = "";
  };

  # Користувачі - ригачі
  users.users.kvarnitz = {
    isNormalUser = true;
    description = "KVarnitZ";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  system.stateVersion = "25.05"; # Теперішня версія системи

  # САМОПИС БЛЯЯЯЯЯЯЯТЬ
  
  # Пакетний менеджер Lix
  nix.package = pkgs.lix;

  # Пакети
  environment.systemPackages = with pkgs; [
    # Cumshot
    grim # Скрінер
    slurp # Виділення екрану
    swappy # GUI для всього
    wl-clipboard # Буфер
    wayfreeze # Замерзання екрану
    # Хуй
    wofi # Меню програм
    xfce.thunar # Файловий менеджер
    xfce.tumbler  # Лоліатюри    
    librewolf # Браузер
    vesktop # Діскорд
    element-desktop # Matrix 
    youtube-music # Музичка
    vlc # Відеопрогравач
    imv # Фотопереглядач
    telegram-desktop # ФСБ транслятор
    qbittorrent # Торент
    protonvpn-gui # VPN
    unstable.davinci-resolve # Відео рекдактор
    kdePackages.kdenlive # Відео редактор 2
    gimp-with-plugins # Фото редактор
    audacity # Аудіо редактор
    obs-studio # Запис відео
    logmein-hamachi # Локальне підключення в інеті
    unityhub # Об'єднуйтесь холопи
    fontforge-gtk # Редактор шрифтів
    # Яйця
    kitty # Термінал
    lite-xl # Нотатник
    baobab # Інфа про диск
    kdePackages.ark # Архіватор
    resources # Системна інфа+процеси
    pavucontrol # Регулятор звуку
    easyeffects # Для редагування звуку
    mangohud # Інфа про пк в іграх
    hyprpaper # Шпалери страху
    woeusb-ng # Для маніпуляцій з віндою
    ntfs3g # Пакет для ntfs
    lm_sensors # Температура пк
    ffmpeg # Угар з кодеками
    # Гратися
    steam # Вентиль в шапці
    hydralauncher # Зелений steam
    protonup-ng # Кастомні протони для стіму
    wine # Імітація Kaldows
    winetricks # Додача до Wine
    gamescope # Маніпуляції з іграми
    heroic # Інші лаунчери в одному
    lutris # Інші лаунчери в одному 2
    prismlauncher # Майнкрафт
    appimage-run # Запускач прог AppImage
    # Дроч
    vulkan-tools # Ясно 
    vulkan-loader # Не їбу
    vulkan-validation-layers # Не їбу
    python3 # Огорни руками мого пітона
    openjdk # Джава
    git # Угар з GitHub
    git-lfs # Для великих файлів GitHub
    gh # Пов'язка з GitHub
  ];

  # Дозвіл -IQ пакетів
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "davinci-resolve"
      "steam"
      "steam-unwrapped"
      "steamcmd"
      "logmein-hamachi"
      "unityhub"
    ];

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Експерементальна ерекція
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Латинська українська
  environment.etc."xkb/symbols/uklat" = {
    text = ''
      default partial alphanumeric_keys
      xkb_symbols "basic" {
          include "us(basic)"
          name[Group1] = "English (US, Ukrainian Latin)";
          # Запасний метод обригання
          key <AB01> { [ z, Z, zcaron, Zcaron ] };
          key <AC02> { [ s, S, scaron, Scaron ] }; 
          key <AB03> { [ c, C, ccaron, Ccaron ] }; 
          key <AC05> { [ g, G, gbreve, Gbreve ] }; 
          # Основний метод обригання
          key <AC06> { [ gbreve, Gbreve, h, H ] };
          key <AC10> { [ scaron, Scaron, scircumflex, Scircumflex ] };
          key <AB08> { [ comma, less, semicolon, less ] };
          key <AB09> { [ period, greater, colon, greater ] };
          key <AC11> { [ apostrophe, quotedbl, ccaron, Ccaron ] };
          key <AD11> { [ bracketleft, braceleft, zcaron, Zcaron ] };
          key <AD12> { [ bracketright, braceright, idiaeresis, Idiaeresis ] };
          
          include "level3(ralt_switch)"
      };
    '';
  };

  # Усяка херь, аби композитори робили
  services.displayManager.sddm.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Програмний угар
  services.dbus.enable = true; # Начебто аби проги обмінювалися щось там
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  boot.kernelModules = [ "fuse" ];

  # Відюха 
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  # Open GList
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      #rocmPackages.clr
      rocmPackages.clr.icd
      rocmPackages.hipcc
      rocmPackages.rocm-device-libs
      rocmPackages.hip-common
      rocmPackages.rocm-smi # Для моніторингу GPU, аналог nvidia-smi
      rocmPackages.rocm-cmake
      rocmPackages.rocm-runtime # Загальні бібліотеки ROCm
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk  # Для 32-bit сумісності
    ];
  };

  # Харчок у список дисків
  fileSystems."/mnt/Smitnyk" = {
    device = "/dev/disk/by-uuid/c0d8bc1f-f271-45d0-9bbe-a2e44eb940bc"; # Вказування точного диску, інакше вони будуть рандомно єднатися
    #device = "/dev/sda1";
    fsType = "ext4";
  };
  fileSystems."/mnt/Zvalysche" = {
    device = "/dev/disk/by-uuid/c67938c7-35a8-4ae8-8caf-2ce0f23b993d"; # Вказування точного диску, інакше вони будуть рандомно єднатися
    #device = "/dev/sdb1";
    fsType = "ext4";
  };

}

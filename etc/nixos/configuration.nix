{ config, pkgs, lib, ... }:

let

  # Завантаження HomeManager  
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;

  # Завантаження konfihy.nix
  konfihyNix = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/KVarnitZ/MyNixOS/main/etc/nixos/konfihy.nix";
    # Цей sha256 дійсний станом на 2025-07-12
    # sha256 отримується через "nix-prefetch-url --type sha256 (посилання) | xargs nix hash to-sri --type sha256"
    sha256 = "ВИКОРИСТАЙТЕ КОМАНДУ ДЛЯ ОТРИМАННЯ sha256";
  };

  # Завантаження zastosunky.nix
  zastosunkyNix = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/KVarnitZ/MyNixOS/main/etc/nixos/zastosunky.nix";
    # Цей sha256 дійсний станом на 2025-07-12
    # sha256 отримується через "nix-prefetch-url --type sha256 (посилання) | xargs nix hash to-sri --type sha256"
    sha256 = "ВИКОРИСТАЙТЕ КОМАНДУ ДЛЯ ОТРИМАННЯ sha256";
  };
in

{

  environment.etc = {
    # Додавання konfihy.nix до /etc/nixos/
    "nixos/konfihy.nix" = {
      source = konfihyNix;
      # copyFrom = konfihyNix;
    };

    # Додавання zastosunky.nix до /etc/nixos/
    "nixos/zastosunky.nix" = {
      source = zastosunkyNix;
      # copyFrom = zastosunkyNix;
    };
  };

  imports =
    [
      #(import "${home-manager}/nixos")
      konfihyNix # Імпорт з nix-store (копія зберігається в /etc/nixos)
      zastosunkyNix # Імпорт з nix-store (копія зберігається в /etc/nixos)
      ./hardware-configuration.nix
      #./test.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "KVarnitZ"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ua";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kvarnitz = {
    isNormalUser = true;
    description = "KVarnitZ";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  system.stateVersion = "25.05"; # Теперішня версія

  environment.systemPackages = with pkgs; [
    # Cumshot
    grim # Скрінер
    slurp # Виділення екрану
    swappy # GUI для всього
    wl-clipboard # Буфер
    wayfreeze # Замерзання екрану
    # Хуй
    wofi # Меню програм
    nemo # Файловий менеджер
    kdePackages.dolphin # Файловий менеджер 2
    chromium # Браузер
    vesktop # Діскорд
    element-desktop # Matrix 
    youtube-music # Музичка
    vlc # Відеопрогравач
    telegram-desktop # ФСБ транслятор
    qbittorrent # Торент
    protonvpn-gui # VPN
    #davinci-resolve # Відео рекдактор
    kdePackages.kdenlive # Ще один відео редактор
    gimp-with-plugins # Фото редактор
    audacity # Аудіо редактор
    obs-studio # Запис відео
    logmein-hamachi # Локальне підключення в інеті
    # Яйця
    kitty # Термінал
    lite-xl # Нотатник
    baobab # Інфа про диск
    libsForQt5.ark # Архіватор
    resources # Системна інфа+процеси
    pavucontrol # Регулятор звуку
    mangohud # Інфа про пк в іграх
    hyprpaper # Шпалери страху
    woeusb-ng # Для маніпуляцій з віндою
    ntfs3g # Пакет для ntfs
    lm_sensors # Температура пк
    # Гратися
    steam # Вентиль в шапці
    heroic # Інші лаунчери в одному
    lutris # Інші лаунчери в одному 2
    prismlauncher # Майнкрафт
    # Дроч
    vulkan-tools # Ясно 
    vulkan-loader # Не їбу
    vulkan-validation-layers # Не їбу
    python3 # Огорни руками мого пітона
    git # Керування системними файлами ядра (похуй)
  ];

  # Дозвіл -IQ пакетів
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "davinci-resolve"
      "steam"
      "steam-unwrapped"
      "logmein-hamachi"
    ];

  # Експерементальна ерекція
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Усяка херь, аби композитор робив
  services.displayManager.sddm.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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
    ];
  };

  # Харчок у список дисків
  fileSystems."/mnt/Smitnyk" = {
    device = "/dev/disk/by-uuid/ВСТАВТЕ UUID ВАШОГО ДИСКУ"; # Вказування точного диску, інакше вони будуть рандомно єднатися
    #device = "/dev/sda1";
    fsType = "ext4";
  };
  fileSystems."/mnt/Zvalysche" = {
    device = "/dev/disk/by-uuid/ВСТАВТЕ UUID ВАШОГО ДИСКУ"; # Вказування точного диску, інакше вони будуть рандомно єднатися
    #device = "/dev/sdb1";
    fsType = "ext4";
  };

}

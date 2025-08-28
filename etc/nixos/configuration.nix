{ config, pkgs, lib, ... }:

let

  # Завантаження HomeManager
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;

  # Можливість вантажити пакети з нестабільного аналу
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };

  # Завантаження konfihy.nix
  konfihyNix = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/KVarnitZ/MyNixOS/main/etc/nixos/konfihy.nix";
    # Цей sha256 дійсний станом на 2025-06-14
    # sha256 отримується через "nix-prefetch-url --type sha256 https://raw.githubusercontent.com/KVarnitZ/MyNixOS/main/etc/nixos/konfihy.nix | xargs nix hash to-sri --type sha256"
    sha256 = "sha256-/q0obG84BPnYO23b8AnINuNwwBS2JbsEsQGpLfdOn/4=";
  };

  # Завантаження zastosunky.nix
  zastosunkyNix = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/KVarnitZ/MyNixOS/main/etc/nixos/zastosunky.nix";
    # Цей sha256 дійсний станом на 2025-06-14
    # sha256 отримується через "nix-prefetch-url --type sha256 https://raw.githubusercontent.com/KVarnitZ/MyNixOS/main/etc/nixos/zastosunky.nix | xargs nix hash to-sri --type sha256"
    sha256 = "sha256-uakUtxbYa4LDZq74t6z198lK8mdePFgpqzZhOdOA95w=";
  };

  # Завантаження temka.nix
  temkaNix = builtins.fetchurl {
    url = https://raw.githubusercontent.com/KVarnitZ/MyNixOS/refs/heads/main/etc/nixos/temka/temka.nix;
    # Цей sha256 дійсний станом на 2025-06-14
    # sha256 отримується через "nix-prefetch-url --type sha256 https://raw.githubusercontent.com/KVarnitZ/MyNixOS/main/etc/nixos/temka/temka.nix | xargs nix hash to-sri --type sha256"
    sha256 = "sha256-P9CUI+2LPP6b//gEW/245q4dx/kKrWIJzNHOiMDAu54=";
  };

  #myNixOSRepo = builtins.fetchTarball {
    #url = "https://github.com/KVarnitZ/MyNixOS/archive/main.tar.gz";
    # Важливо! Вам потрібно буде оновити цей sha256 щоразу, коли ви вносите зміни до репозиторію.
    # Для отримання нового хешу виконайте в терміналі:
    # nix-prefetch-url --type sha256 https://github.com/KVarnitZ/MyNixOS/archive/main.tar.gz | xargs nix hash to-sri --type sha256
    #sha256 = "sha256-cBtgym/VzVQP3kbCQWgLLbnpE+KSz50m5bVhOSZFe3o=";
  #};
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
   
   # Додавання temka.nix до /etc/nixos/temka/
   "nixos/temka/temka.nix" = {
      source = temkaNix;
      # copyFrom = temkaNix;
    };
  };

  imports =
    [
      #(import "${home-manager}/nixos")
      konfihyNix # Імпорт з nix-store (копія зберігається в /etc/nixos)
      zastosunkyNix # Імпорт з nix-store (копія зберігається в /etc/nixos)
      temkaNix # # Імпорт з nix-store (копія зберігається в /etc/nixos/temka)
      ./hardware-configuration.nix
      ./shryftyky.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "KVarnitZ"; # Define your hostname.

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
    chromium # Браузер
    vesktop # Діскорд
    element-desktop # Matrix 
    youtube-music # Музичка
    vlc # Відеопрогравач
    telegram-desktop # ФСБ транслятор
    qbittorrent # Торент
    protonvpn-gui # VPN
    davinci-resolve # Відео рекдактор
    kdePackages.kdenlive # Відео редактор 2
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
    protonup-ng # Кастомні протони для стіму
    wine
    gamescope # Маніпуляції з іграми
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

  # Дозвіл (1000-7)*2 пакетів
  nixpkgs.overlays = [
    (self: super: {
      davinci-resolve = unstable.davinci-resolve;
    })
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

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kvarnitz = {
    isNormalUser = true;
    description = "KVarnitZ";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  environment.systemPackages = with pkgs; [
    # Cumshot
    grim # Скрінер
    slurp # Виділення екрану
    swappy # GUI для всього
    wl-clipboard # Буфер
    # Хуй
    wofi # Меню програм
    nemo # Файловий менеджер
    chromium # Браузер
    vesktop # Діскорд 
    spotify # Музичка
    vlc # Відеопрогравач
    telegram-desktop # ФСБ транслятор
    viber # Хуйняйбер
    qbittorrent # Торент
    protonvpn-gui # VPN
    davinci-resolve # Відео рекдактор
    gimp-with-plugins # Фото редактор
    audacity # Аудіо редактор
    obs-studio # Запис відео
    # Яйця
    kitty # Термінал
    lite-xl # Нотатник
    baobab # Інфа про диск
    resources # Системна інфа+процеси
    pavucontrol # Регулятор звуку
    mangohud # Інфа про пк в іграх
    # Гратися
    steam # Вентиль в шапці
    prismlauncher # Майнкрафт
    # Дроч
    vulkan-tools # Ясно 
    vulkan-loader # Не їбу
    vulkan-validation-layers # Не їбу
  ];

  # Дозвіл -IQ пакетів
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
      "viber"
      "davinci-resolve"
      "steam"
      "steam-unwrapped"
    ];

  programs.steam = {
    enable = true;
    extraEnv = {
    MANGOHUD = "1";
    };
  };

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
  };

  # Харчок у список дисків
  fileSystems."/mnt/Smitnyk" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

}

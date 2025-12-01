{ config, pkgs, lib, unstable, ... }:

{
  imports = 
    [  
      ./hardware-configuration.nix
      #./transljator.nix
      ./server.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "KVarnitZ"; # Šo ty, ğolova?

  # Internat
  networking.networkmanager.enable = true;

  # De ja?
  time.timeZone = "Europe/Kyiv";

  # Movne pytannja
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

  # Zvuk ta ekran
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Klavišy tykaty X11
  services.xserver.xkb = {
    layout = "us,ua";
    variant = "";
  };

  # Korystuvači - ryğači
  users.users.kvarnitz = {
    isNormalUser = true;
    description = "KVarnitZ";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  system.stateVersion = "25.11"; # Versija systemy

  # SAMOPYS BLJAAAAATJ
  
  # Paketnyj menedžer Lix
  nix.package = pkgs.lix;

  # Pakety
  environment.systemPackages = with pkgs; [
    # Cumshot
    grim # Skriner
    slurp # Vydilennja ekranu
    swappy # GUI dlja vsjoğo
    wl-clipboard # Bufer
    wayfreeze # Zamerzannja ekranu
    # Xuj
    wofi # Menju proğram
    xfce.thunar # Fajlovyj menedžer
    xfce.tumbler  # Loliatjury    
    librewolf # Brauzer
    vesktop # Diskord
    element-desktop # Matrix 
    youtube-music # Muzyčka
    vlc # Videoproğravač
    imv # Fotopereğljadač
    telegram-desktop # FSB transljator
    qbittorrent # Torent
    protonvpn-gui # VPN
    unstable.davinci-resolve # Video rekdaktor
    kdePackages.kdenlive # Video redaktor 2
    gimp-with-plugins # Foto redaktor
    audacity # Audio redaktor
    (pkgs.wrapOBS { # OBS
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })
    logmein-hamachi # Lokaljne pidključennja v ineti
    unityhub # Ob'jednujtesj xolopy
    fontforge-gtk # Redaktor šryftiv
    # Jajcja
    kitty # Terminal
    lite-xl # Notatnyk
    baobab # Infa pro dysk
    kdePackages.ark # Arxivator
    thunderbird # Pošta
    resources # Systemna infa+procesy
    pavucontrol # Reğuljator zvuku
    easyeffects # Dlja redağuvannja zvuku
    mangohud # Infa pro pk v iğrax
    hyprpaper # Špalery straxu
    woeusb-ng # Dlja manipuljacij z vindoju
    ntfs3g # Paket dlja ntfs
    lm_sensors # Temperatura pk
    ffmpeg # Uğar z kodekamy
    # Ğratysja
    steam # Ventylj v šapci
    hydralauncher # Zelenyj steam
    protonup-ng # Kastomni protony dlja stimu
    wine # Imitacija Kaldows
    winetricks # Dodača do Wine
    gamescope # Manipuljaciï z iğramy
    heroic # Inši launčery v odnomu
    lutris # Inši launčery v odnomu 2
    prismlauncher # Majnkraft
    appimage-run # Zapuskač proğ AppImage
    # Droč
    vulkan-tools # Jasno 
    vulkan-loader # Ne ïbu
    vulkan-validation-layers # Ne ïbu
    python3 # Oğorny rukamy moğo pitona
    helvum
    openjdk # Džava
    git # Uğar z GitHub
    git-lfs # Dlja velykyx fajliv GitHub
    gh # Pov'jazka z GitHub
  ];

  # Dozvil -IQ paketiv
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "davinci-resolve"
      "steam"
      "steam-unwrapped"
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

  # Eksperementaljna erekcija
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Latynsjka Ukraïnsjka
  environment.etc."xkb/symbols/uklat" = {
    text = ''
      default partial alphanumeric_keys
      xkb_symbols "basic" {
          include "us(basic)"
          name[Group1] = "English (US, Ukrainian Latin)";
          # Zapasnyj merod ryğu
          key <AB01> { [ z, Z, zcaron, Zcaron ] };
          key <AC02> { [ s, S, scaron, Scaron ] }; 
          key <AB03> { [ c, C, ccaron, Ccaron ] }; 
          key <AC05> { [ g, G, gbreve, Gbreve ] }; 
          # Osnovnyj metod ryğu
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

  # Usjaka xerj, aby kompozytory robyly
  services.displayManager.sddm.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Proğramnyj uğar
  services.dbus.enable = true; # Načebto aby proğy obminjuvalysja šosj tam
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  boot.kernelModules = [ "fuse" ];

  # Vudjuxa
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
      rocmPackages.rocm-smi # Dlja monitorynğu GPU, analoğ nvidia-smi
      rocmPackages.rocm-cmake
      rocmPackages.rocm-runtime # Zağaljni biblioteky ROCm
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk  # Dlja 32-bit sumisnosti
    ];
  };

  # Xarčok u spysok dyskiv
  fileSystems."/mnt/Smitnyk" = {
    device = "/dev/disk/by-uuid/c0d8bc1f-f271-45d0-9bbe-a2e44eb940bc"; # Vkazuvannja točnoğo dysku, inakše vony budutj vypadkovo jednatysja
    fsType = "ext4";
  };
  fileSystems."/mnt/Zvalyŝe" = {
    device = "/dev/disk/by-uuid/c67938c7-35a8-4ae8-8caf-2ce0f23b993d"; # Vkazuvannja točnoğo dysku, inakše vony budutj vypadkovo jednatysja
    fsType = "ext4";
  };
  fileSystems."/mnt/Durmanyk" = {
    device = "/dev/disk/by-uuid/b38de0ac-9e58-4027-9b8b-ab5e11e4284b"; # Vkazuvannja točnoğo dysku, inakše vony budutj vypadkovo jednatysja
    fsType = "ext4";
  };

}

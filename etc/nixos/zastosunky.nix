{

  home-manager.users.kvarnitz = {
    home.stateVersion = "25.11"; # Мудак version
    # Steam
    home.file.".local/share/applications/steam.desktop".text = ''
[Desktop Entry]
Name=Steam(MangoHud)
Comment=Application for managing and playing games on Steam
Comment[uk]=Програма для керування іграми та запуску ігор у Steam
Exec=env MANGOHUD=1 steam %U
Icon=steam
Terminal=false
Type=Application
Categories=Network;FileTransfer;Game;
MimeType=x-scheme-handler/steam;x-scheme-handler/steamlink;
Actions=Store;Community;Library;Servers;Screenshots;News;Settings;BigPicture;Friends;
PrefersNonDefaultGPU=true
X-KDE-RunOnDiscreteGpu=true

[Desktop Action Store]
Name=Store
Name[uk]=Крамниця
Exec=steam steam://store

[Desktop Action Community]
Name=Community
Name[uk]=Спільнота
Exec=steam steam://url/SteamIDControlPage

[Desktop Action Library]
Name=Library
Name[uk]=Бібліотека
Exec=steam steam://open/games

[Desktop Action Servers]
Name=Servers
Name[uk]=Сервери
Exec=steam steam://open/servers

[Desktop Action Screenshots]
Name=Screenshots
Name[uk]=Скріншоти
Exec=steam steam://open/screenshots

[Desktop Action News]
Name=News
Name[uk]=Новини
Exec=steam steam://open/news

[Desktop Action Settings]
Name=Settings
Name[uk]=Налаштування
Exec=steam steam://open/settings

[Desktop Action BigPicture]
Name=Big Picture
Exec=steam steam://open/bigpicture

[Desktop Action Friends]
Name=Friends
Name[uk]=Друзі
Exec=steam steam://open/friends
    '';
  };
}

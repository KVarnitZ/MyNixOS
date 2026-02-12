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
    # DTEK ğrafik
    home.file.".local/share/applications/DTEK.desktop".text = ''
[Desktop Entry]
Name=DTEK ğrafik
Comment=ДТЕК, Дтек, дтек, DTEK, Dtek, dtek, Світло, світло, Svitlo, svitlo, LNTR, Lntr, lntr, ВЕУЛ, Веул, веул, Імшедщ, імшедщ, Cdsnkj, cdsnkj
Exec=sh -c "python3 /home/kvarnitz/.local/share/applications/DTEK/dtek.py | wofi --show dmenu --prompt 'Графік світла' --width 500 --height 600 --cache-file /dev/null --no-actions --hide-scroll"
Terminal=false
Type=Application
Categories=FUCK rUSSIA;
    '';
  };
}

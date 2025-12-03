# MyNixOS
Moja samorobna systema NixOS 25.11 Xantusia
## Латиниця
Усе написано українською мовою за офіційною системою А державного стандарту України 9112:2021. Ось [Транслітератор](https://kvarnitz.github.io/UkrainianTransliterator/), який можна використовувати для переведення тексту в кирилицю та навпаки, якщо буде складно читати.
## Metod
Ğolovnyj fajl konfiğuraciï ce [flake.nix](/etc/nixos/flake.nix), pidvantažuje vsi fajly z cjoğo repozytorija. Cej metod robe systemu leğkoju dlja vidnovlennja, bo potriben vsjoğo lyše [flake.nix](/etc/nixos/flake.nix) ([configuration.nix](/etc/nixos/configuration.nix) xoč i prysutnij u repozytoriï, prote avtomatyčno ne zadijan, bo inakše bulo by skladno pracjuvaty z systemoju). Tak samo zminjuvaty konfiğy, jaki poza cym fajlom, potribno čerez GitHub. Cej šljax troxy dovšyj, ale bezpečnyj ta dozvoljaje vidslidkovuvaty proğres. Raniše ce pracjuvalo bez flake, a same čerez ručnu zaminu sha256, tobto xešu, bo pislja zminy fajla vin onovljujetjsja. Teper že [flake.nix](/etc/nixos/flake.nix) samostijno zanosytj vse do ```flake.lock``` Usi stvorennja fajliv robljatjsja čerez ```home-manager```, navitj hyprland. Kožen majbutnij fajl, jakyj je častynoju deklaratyvnoï systemy abo pereneseno, abo bude pereneseno do [home.nix](/etc/nixos/home.nix).
## Systema
- **Hyprland (Wayland)**
- **AMD CPU/GPU (descrete)**

Bula konfiğuracija pid nvidia videokartu, ale zanadto bağato problem z cym. Najkraŝym vyborom bulo naprosto kupyty amd videokartu ta povnistju perefarbuvatysja v červonyj. Dodano [unstable](/etc/nixos/flake.nix) jak input, ŝoby možna bulo zavantažuvaty okremi nestabiljni pakety, pry cjomu dozvoljajučy lyše ci konkretni pakety (takož možna maty **odnočasno stabiljnyj ta nestabiljnyj paket** pry bažanni, bo nestabiljnyj paket zavždy povynen maty prefiks "unstable" na počatku, ale dozvil unfree pracjuje na obox).
## Temka
- GTK = **Catppuchinn Latte Yellow Compact**
- QT = **Catppuchinn Latte Yellow**
- Cursor = **Ju-Fufu**
- Icons = **BeautyDream-GTK**

Za konfiğuraciju temy vidpovidaje [temka.nix](/etc/nixos/temka/temka.nix)
## Konfiğy/Skrypty
- **MangoHud(+Steam)**

Nalaštovano na pokaz vyključno FPS zverxu zliva ta ```steam.desktop``` z MangoHud.
- **VolumeDominatorKVZ**

Trymač zvuku mikrofona na 100%. Vykorystvuje dlja cjoğo Default Device.
- **Wofi**

Dodano vidobražennja ikonok pry vybori proğram čerez ```drum```.
- **Hyprpaper**

Špalery na vsi ekrany za konkretnoju dyrektorijeju.
- **Skreenshot**

Vnedreno prjamo v Hyprland za bindom ```SUPER+SHIFT+S```. Ekran **zastyğaje**, pislja čoğo možna vydilyty oblastj dlja skrinšotu, potim potribno natysnuty ```Esc```, ŝoby zupynyty zastyğannja, vidkryvajetjsja instrument, de možna ŝosj namaljuvaty na skrinšoti ta skopijuvaty stvorene.
- **Ukrainian Latin**

Zrobleno novu rozkladku ukraïnsjkoï latynyci, jaka zaminjaje anğlijsjku povnistju. Vykorystovujetjsja dlja anğlijsjkoï ta ukraïnjskoï odnočasno.

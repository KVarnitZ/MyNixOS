{
    
  home-manager.users.kvarnitz = {
    home.stateVersion = "25.11"; # Mudak versija
    # Hyprland
    home.file."/.config/hypr/hyprland.conf".text = ''
env = QT_QPA_PLATFORMTHEME,qt6ct

# Metod rozbyttja konfiğuraciï na okremi fajly
# source = ~/.config/hypr/myColors.conf

# Nalaštuvannja monitoriv
monitor=,preferred,auto,auto

# Standartni proğy
$terminal = kitty
$fileManager = thunar
$menu = wofi --show drun

exec = ~/.config/neuronkiller/volume-dominator-kvz.sh
exec = hyprpaper
exec-once = easyeffects --gapplication-service

#########################
### ZMINNI SEREDOVYŜA ###
#########################

env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24

###############
### DOZVOLY ###
###############

# ecosystem {
#   enforce_permissions = 1
# }

# permission = /usr/(bin|local/bin)/grim, screencopy, allow
# permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
# permission = /usr/(bin|local/bin)/hyprpm, plugin, allow


############################
### VYĞLJAD TA VIDČUTTJA ###
############################

# Dyvitjsja https://wiki.hyprland.org/Configuring/Variables/

# https://wiki.hyprland.org/Configuring/Variables/#general
general {
    gaps_in = 2
    gaps_out = 4

    border_size = 2

    # https://wiki.hyprland.org/Configuring/Variables/#variable-types dlja informaciju pro koljory
    col.active_border = rgba(ffcf00ee) rgba(ffa000ee) 45deg
    col.inactive_border = rgba(595959aa)

    # Set to true enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false

    # Budj laska dyvitjsja https://wiki.hyprland.org/Configuring/Tearing/ pered uvimknennjam
    allow_tearing = false

    layout = dwindle
}

# https://wiki.hyprland.org/Configuring/Variables/#decoration
decoration {
    rounding = 1
    rounding_power = 3

    # Zminyty prozoristj fokusovanyx i nefokusovanyx nejroniv
    active_opacity = 1.0
    inactive_opacity = 1.0

    shadow {
        enabled = true
        range = 4
        render_power = 3
        color = rgba(1a1a1aee)
    }

    # https://wiki.hyprland.org/Configuring/Variables/#blur
    blur {
        enabled = true
        size = 3
        passes = 1

        vibrancy = 0.1696
    }
}

# https://wiki.hyprland.org/Configuring/Variables/#animations
animations {
    enabled = yes, please :)

    # Standartni animaciï, dyvitjsja https://wiki.hyprland.org/Configuring/Animations/ dlja biljšoğo

    bezier = easeOutQuint,0.23,1,0.32,1
    bezier = easeInOutCubic,0.65,0.05,0.36,1
    bezier = linear,0,0,1,1
    bezier = almostLinear,0.5,0.5,0.75,1.0
    bezier = quick,0.15,0,0.1,1

    animation = global, 1, 10, default
    animation = border, 1, 5.39, easeOutQuint
    animation = windows, 1, 4.79, easeOutQuint
    animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
    animation = windowsOut, 1, 1.49, linear, popin 87%
    animation = fadeIn, 1, 1.73, almostLinear
    animation = fadeOut, 1, 1.46, almostLinear
    animation = fade, 1, 3.03, quick
    animation = layers, 1, 3.81, easeOutQuint
    animation = layersIn, 1, 4, easeOutQuint, fade
    animation = layersOut, 1, 1.5, linear, fade
    animation = fadeLayersIn, 1, 1.79, almostLinear
    animation = fadeLayersOut, 1, 1.39, almostLinear
    animation = workspaces, 1, 1.94, almostLinear, fade
    animation = workspacesIn, 1, 1.21, almostLinear, fade
    animation = workspacesOut, 1, 1.94, almostLinear, fade
}

# Dyvitjsja https://wiki.hyprland.org/Configuring/Workspace-Rules/
# "Smart gaps" / "No gaps when only"
# uncomment all if you wish to use that.
# workspace = w[tv1], gapsout:0, gapsin:0
# workspace = f[1], gapsout:0, gapsin:0
# windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
# windowrule = rounding 0, floating:0, onworkspace:w[tv1]
# windowrule = bordersize 0, floating:0, onworkspace:f[1]
# windowrule = rounding 0, floating:0, onworkspace:f[1]

# Dyvitjsja https://wiki.hyprland.org/Configuring/Dwindle-Layout/ dlja biljšoğo
dwindle {
    pseudotile = true # Ğolovnyj peremykač dlja psevdoplytky. Uvimknennja pryv'jazane do mainMod + P u rozdili klavišnyx kombinacij nyžče.
    preserve_split = true # Vy, mabutj, xočete ce
}

# Dyvitjsja https://wiki.hyprland.org/Configuring/Master-Layout/ dlja biljšoğo
master {
    new_status = master
}

# https://wiki.hyprland.org/Configuring/Variables/#misc
misc {
    force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = true # If true disables the random hyprland logo / anime girl background. :(
}


#################
### VVEDENNJA ###
#################

# https://wiki.hyprland.org/Configuring/Variables/#input
input {
    kb_layout = uklat,ua
    kb_variant =
    kb_model =
    kb_options = grp:win_space_toggle
    kb_rules =

    follow_mouse = 1

    sensitivity = -0.9 # -1.0 - 1.0, 0 označaje vidsutnistj modyfikacij.

    touchpad {
        natural_scroll = false
    }
}

# Pryklad konfiğuraciï dlja kožnoji prybludy
# Dyvitjsja https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs dlja biljšoğo
device {
    name = epic-mouse-v1
    sensitivity = -0.5
}


#######################
### ĞORJAČI KLAVIŠY ###
#######################

# Znjatok
bind = SUPER+SHIFT, S, exec, flameshot gui --delay 500

$mainMod = SUPER # Klaviša "Windows"

# Ğarjači klavišy
bind = $mainMod, Q, exec, $terminal                                      # Vidkryty terminal
bind = $mainMod, C, killactive,                                          # Zakryty zastosunok (ne vynyŝyty)
bind = $mainMod, M, exit,                                                # Vyjty z hyprland
bind = $mainMod, E, exec, $fileManager                                   # Fajlovyj menedžer
bind = $mainMod, V, togglefloating,                                      # Plavajuči vikna
bind = $mainMod, F, fullscreen,                                          # Povnyj ekran
bind = $mainMod, R, exec, $menu                                          # Menju zapusku proğram
bind = $mainMod, P, pseudo,                                              # Zafiksuvaty vikno
bind = $mainMod, J, togglesplit,                                         # Zminyty položennja vikon

# Rux fokusa
bind = $mainMod, left, movefocus, l                                      # Peremknuty fokus livoruč
bind = $mainMod, right, movefocus, r                                     # Peremknuty fokus pravoruč
bind = $mainMod, up, movefocus, u                                        # Peremknuty fokus uğoru
bind = $mainMod, down, movefocus, d                                      # Peremknuty fokus unyz
bind = $mainMod_SHIFT, left, movewindow, l                               # Peremistyty vikno livoruč
bind = $mainMod_SHIFT, right, movewindow, r                              # Peremistyty vikno pravoruč
bind = $mainMod_SHIFT, up, movewindow, u                                 # Peremistyty vikno vğoru
bind = $mainMod_SHIFT, down, movewindow, d                               # Peremistyty vikno vnyz

# Peremykannja bezrobitnix prostoriv z mainMod + [0-9]
bind = $mainMod, 1, workspace, 1                                         # Perejty na roboču oblastj 1
bind = $mainMod, 2, workspace, 2                                         # Perejty na roboču oblastj 2
bind = $mainMod, 3, workspace, 3                                         # Perejty na roboču oblastj 3
bind = $mainMod, 4, workspace, 4                                         # Perejty na roboču oblastj 4
bind = $mainMod, 5, workspace, 5                                         # Perejty na roboču oblastj 5
bind = $mainMod, 6, workspace, 6                                         # Perejty na roboču oblastj 6
bind = $mainMod, 7, workspace, 7                                         # Perejty na roboču oblastj 7
bind = $mainMod, 8, workspace, 8                                         # Perejty na roboču oblastj 8
bind = $mainMod, 9, workspace, 9                                         # Perejty na roboču oblastj 9
bind = $mainMod, 0, workspace, 10                                        # Perejty na roboču oblastj 10

# Perekydannja ğnojnyx vikon + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10

# Mağija «Voda na Vyno» (scratchpad)
#bind = $mainMod, S, togglespecialworkspace, magic
#bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Peremykannja čerez prokručuvannja pljašky mainMod + koliŝatko
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Rux/zmina rozmiru vikon z mainMod + LKM/PKM ta rux ŝura
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Muljtymedijni klavišy dlja zvuku ta jaskravosti mordy
bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

# Vymoğa playerctl
bindl = , XF86AudioNext, exec, playerctl next
bindl = , XF86AudioPause, exec, playerctl play-pause
bindl = , XF86AudioPlay, exec, playerctl play-pause
bindl = , XF86AudioPrev, exec, playerctl previous

################################
### VIKNA TA ROBOČI PROSTORY ###
################################

# Dyvitjsja https://wiki.hyprland.org/Configuring/Window-Rules/ dlja biljšoğo
# Dyvitjsja https://wiki.hyprland.org/Configuring/Workspace-Rules/ dlja pravyl robočyx prostoriv

# Pryklad pravyla vikna
# windowrule = float,class:^(kitty)$,title:^(kitty)$

# Iğnoruvannja zapytiv na maksymizaciju vid urodiv.
windowrule = suppressevent maximize, class:.*

# Vypravleno dejaki problemy z peretjağuvannjam XWayland
windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
    '';
    # Aby ïbalo počervonilo
    home.file."/.config/hypr/hyprpaper.conf".text = ''
preload = ~/.config/hypr/Wallpaper.jpg
wallpaper = , ~/.config/hypr/Wallpaper.jpg
    '';
    # Ŝoby IQ pokazuvalo
    home.file."/.config/MangoHud/MangoHud.conf".text = ''
fps_only
fps_limit=75
font_size_text=12
background_alpha=0
    '';
    # Dominacija nad zvukom, postijna zmina mikrovona na 100%
    home.file."/.config/neuronkiller/volume-dominator-kvz.sh" = { text = ''
while true; do
    wpctl set-volume @DEFAULT_SOURCE@ 1
    sleep 0.1
done
    '';
    executable = true;
    };
    # Nalaštuvannja zapuskača proğram
    home.file."/.config/wofi/config".text = ''
mode=drun
allow_images=true
image_size=25
    '';
  };
}


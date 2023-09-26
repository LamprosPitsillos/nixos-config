{...}: {
  wayland.windowManager.hyprland = {
    enableNvidiaPatches = true;
    xwayland.enable = true;

    enable = true;
    # settings = rec {
    #     MOD = "SUPER";
    #
    #
    #
    #     };
    extraConfig = ''
      #
      # Please note not all available settings / options are set here.
      # For a full list, see the wiki
      #

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=eDP-1,1920x1080,0x0 ,1
      monitor=,preferred,auto,1


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf


      # Some default env vars.
      env = XCURSOR_SIZE,20

      source = ~/.config/hypr/monitors.conf

      exec-once =  hyprpaper &
      exec-once =  dunst &
      exec-once = eww open bar & # hyprpaper & firefox
      exec-once = hyprctl setcursor "Bibata-Modern-Ice" 8

      misc {
      close_special_on_empty=true
      disable_splash_rendering = true
      disable_hyprland_logo = true
      enable_swallow=true
      animate_manual_resizes=false
      swallow_regex=^(kitty)$
      # swallow_regex="(vifm|zathura|mpv)"
      }

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us,gr
          kb_variant =
          kb_model =
          kb_options = caps:escape
          kb_rules =
          numlock_by_default=true
          repeat_rate=50
          repeat_delay=250
          follow_mouse = 1

          touchpad {
              natural_scroll = true
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 3
          gaps_out = 10
          border_size = 2
          col.active_border = rgba(FFB53AEE) rgba(EF990EEE) 45deg
          col.inactive_border = rgba(595959aa)
          cursor_inactive_timeout=5
          layout = dwindle
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 4

          drop_shadow = true
          shadow_range = 6
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)

          blur {

              enabled = true
              size = 3
              passes = 1
              new_optimizations = true
          }
      }

      animations {
          enabled = true

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 2, myBezier
          animation = windowsOut, 1, 2, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1 , 1, default
          animation = workspaces, 1, 4, default
          animation = specialWorkspace, 1, 4, default, fade
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = false # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = false
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device:epic mouse V1 {
          sensitivity = -0.5
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$

      windowrulev2 = noinitialfocus,class:^(com-eteks-sweethome3d-SweetHome3DBootstrap)$
      windowrulev2 = nofocus,class:^(com-eteks-sweethome3d-SweetHome3DBootstrap)$,title:^(win1)$

      # Example windowrule v2
      windowrulev2 = fullscreen,class:^(Waydroid)$
      windowrulev2 = float,class:nm-connection-editor
      # windowrulev2 = dimaround,fullscreen:1
      # windowrulev2 = bordersize 8,fullscreen:1
      # windowrulev2 = move %100 %100,class:nm-connection-editor
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER
      $hyprscripts= ~/.config/hypr/scripts
      $scripts= $SCRIPTS

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod,return, exec, kitty -1
      #bind = $mainMod, period , exec,[workspace special:terminal] kitty
      bind = $mainMod, period , exec, $hyprscripts/scratchpads terminal
      bind =,Menu ,exec, hyprctl switchxkblayout kanata next
      bind =,Print ,exec, $scripts/screenshot-sh full
      bind =SHIFT,Print ,exec, $scripts/screenshot-sh
      bind =$mainMod,Print ,exec,$scripts/screen-rec.sh
      bind =$mainMod SHIFT,Print ,exec,$scripts/screen-rec.sh area
      bind =$mainMod,B ,exec,eww open --toggle bar

      #grim -g "$(slurp)" - | swappy -f - -o $HOME/pics/Screenshot/"$(date +'%Y-%m-%d_%H-%M-%S')_$(echo | tofi --prompt-text="Name: " --require-match=false --height=8% | tr " " "_")"
      bind = $mainMod, W, killactive,
      bind = $mainMod ALT, X, exec , eww open --toggle bar && eww open --toggle powermenu
      bind = $mainMod SHIFT, q, exit,
      bind = $mainMod, E, exec, thunar
      # bind = $mainMod, comma , exec,[stayfocused;dimaround;float;size 50% 40%;center(1) ] kitty vifm
      bind = $mainMod, comma , exec, $hyprscripts/scratchpads file_manager
      bind = $mainMod, M , exec, $hyprscripts/scratchpads music_player
      bind = $mainMod, T, togglefloating,
      bind = $mainMod, F , fullscreen,0
      bind = $mainMod, space, exec, $( tofi-drun )
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, s, togglesplit, # dwindle
      # bind = $mainMod, I , exec, [workspace 1;] kitty

      #
      # bind = $mainMod SHIFT, I , movetoworkspace,special:fullscreen
      # bind = $mainMod CTRL, I , movetoworkspace,
      # bind = $mainMod, I , togglespecialworkspace,fullscreen

      # Move focus with mainMod + arrow keys
      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5

      bind = $mainMod SHIFT, h, movewindow, l
      bind = $mainMod SHIFT, j, movewindow, d
      bind = $mainMod SHIFT, k, movewindow, u
      bind = $mainMod SHIFT, l, movewindow, r


      binde= ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0
      binde= ,XF86AudioLowerVolume, exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0
      binde= ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

      binde= ,XF86MonBrightnessDown,exec,brightnessctl set 100- -q
      binde= ,XF86MonBrightnessUp,exec,brightnessctl set 100+ -q

      bindl=,XF86AudioPlay,exec,$scripts/music-player/music-ctrl-sh toggle
      bindl=,XF86AudioPrev,exec,$scripts/music-player/music-ctrl-sh prev
      bindl=,XF86AudioNext,exec,$scripts/music-player/music-ctrl-sh next
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      bind=$mainMod,o,submap,open

      submap=open
      bind=,Q,exec,$scripts/qute_search.sh
      bind=,Q,submap,reset
      bind=,escape,submap,reset
      submap=reset


      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod SHIFT, mouse:272, resizewindow

    '';
  };
}
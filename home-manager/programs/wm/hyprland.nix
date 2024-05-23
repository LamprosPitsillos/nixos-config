{ pkgs, lib, ... }: {

  wayland.windowManager.hyprland = {
    xwayland.enable = true;

    enable = true;

    extraConfig =
      let
        scripts = (pkgs.callPackage ./scripts.nix { });
        system_scripts = (pkgs.callPackage ./../../../scripts { });
      in
        /* hyprlang */
      ''
        #--------------------------------------------------------------------#
        #                                Docs                                #
        #               https://wiki.hyprland.org/Configuring                #
        #--------------------------------------------------------------------#

        monitor= eDP-1, 1920x1080, 0x0 ,1
        monitor=,preferred,auto,1

        env = XCURSOR_SIZE,20
        env = _JAVA_OPTIONS,'-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

        source = ~/.config/hypr/monitors.conf

        exec-once =  hyprpaper &
        exec-once =  swaync &
        exec-once = eww open bar &

        # exec-once = ags &
        exec-once = hyprctl setcursor "Bibata-Modern-Ice" 8

        $ON = 1
        $OFF = 0

        misc {
        close_special_on_empty=true
        disable_splash_rendering = true
        disable_hyprland_logo = true
        enable_swallow=true
        animate_manual_resizes=false
        swallow_regex=^(kitty)$
        }
        # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
        input {
            kb_layout = us,gr
            kb_variant =
            kb_model =
            kb_options = caps:escape
            kb_rules =
            numlock_by_default=true
            repeat_rate=20
            repeat_delay=400
            follow_mouse = on

            touchpad {
                natural_scroll = true
                disable_while_typing = true
            }

            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        }

        general {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            gaps_in = 3
            gaps_out = 10
            gaps_workspaces = 40

            border_size = 3
            col.active_border = rgba(FFB53AEE) rgba(EF990EEE) 45deg
            col.inactive_border = rgba(595959AA)
            layout = dwindle
        }

        cursor {
            inactive_timeout = 5
        }
        group {

                col.border_active = rgba(FFB53AEE) rgba(EF990EEE) 45deg
                col.border_inactive = rgba(595959AA)
            groupbar {
                height = 30
                gradients = false
                font_family = "JetBrainsMono NF"
                col.active = rgba(FFB53AEE) rgba(EF990EEE) 45deg
                col.inactive = rgba(595959AA)
            }
        }

        decoration {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            rounding = 4

            drop_shadow = true
            shadow_range = 6
            shadow_render_power = 3
            col.shadow = rgba(1A1A1AEE)

            blur {

                special = true
                enabled = true
                size = 8
                passes = 2
                xray = true
                new_optimizations = true
                vibrancy = 0.6
                vibrancy_darkness = 0.6
                contrast = 1.0
                popups = true
            }
        }
        debug {
                disable_logs = true
                disable_time = true
                watchdog_timeout = 2
        }
        animations {
            enabled = true
            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier =       myBezier, 0.05, 0.9,  0.1, 1.05
            bezier =     easeInSine, 0.12,   0, 0.39,    0
            bezier =    easeOutSine, 0.61,   1, 0.88,    1
            bezier =  easeInOutSine, 0.37,   0, 0.63,    1
            bezier =    easeInCubic, 0.32,   0, 0.67,    0
            bezier =   easeOutCubic, 0.33,   1, 0.68,    1
            bezier = easeInOutCubic, 0.65,   0, 0.35,    1

            animation = windows, 1, 2, myBezier, popin
            animation = windowsOut, 1, 2, easeOutCubic, popin 80%
            animation = border, 1, 5, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 5, default
            animation = layers, 1, 1, myBezier, fade
            animation = workspaces, 1, 4, default
            animation = specialWorkspace, 1, 4, default, fade

        }

        dwindle {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = true
            preserve_split = true
            special_scale_factor = 0.8
        }

        master {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = true
            special_scale_factor = 0.8


            # bind=$mainMod SHIFT,j,layoutmsg,swapnext
            # bind=$mainMod SHIFT,k,layoutmsg,swapprev
            # bind=$mainMod SHIFT,h,layoutmsg,addmaster
            # bind=$mainMod SHIFT,l,layoutmsg,removemaster
            # bind=$mainMod SHIFT,m,layoutmsg,swapwithmaster

        }

        gestures {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = false
        }

        # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more

        device {
            name = epic mouse V1
            sensitivity = -0.5
        }

        # Example windowrule v1
        # windowrule = float, ^(kitty)$

        windowrulev2 = noinitialfocus,class:^(com-eteks-sweethome3d-SweetHome3DBootstrap)$
        windowrulev2 = tile,class:^(com-eteks-sweethome3d-SweetHome3DBootstrap)$
        windowrulev2 = nofocus,class:^(com-eteks-sweethome3d-SweetHome3DBootstrap)$,title:^(win\d+)$
        windowrulev2 = float,class:^(com-eteks-sweethome3d-SweetHome3DBootstrap)$,title:^(win\d+)$

        # windowrulev2 = noinitialfocus,class:^(steam)$
        # windowrulev2 = nofocus,class:^(steam)$


        # Example windowrule v2
        windowrulev2 = fakefullscreen,workspace special:music_player,class:^(mpv)$

        # windowrulev2 = nomaximizerequest,class:^(mpv)$
        windowrulev2 = suppressevent maximize,class:^(mpv)$
        windowrulev2 = float,class:^(qalculate-gtk)$

        windowrulev2 = fakefullscreen,class:^(firefox-typst-preview)$
        windowrulev2 = float,class:nm-connection-editor
        # windowrulev2 = workspace +1 ,onworkspace:1,workspace special:music_player
        windowrulev2 = pin,class:swappy
        windowrulev2 = pin,class:com.gabm.satty

        # windowrulev2 = dimaround,fullscreen:1
        # windowrulev2 = bordersize 8,fullscreen:1
        # windowrulev2 = move %100 %100,class:nm-connection-editor
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        $mainMod = SUPER

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod,return, exec, kitty
        #bind = $mainMod, period , exec,[workspace special:terminal] kitty
        bind = $mainMod, period , exec, ${scripts.scratchpad} terminal "kitty "
        bind =,Menu ,exec, hyprctl switchxkblayout kanata next
        bind =,Print ,exec, ${system_scripts.screen_shot} full
        bind = SHIFT,Print ,exec, ${system_scripts.screen_shot} area
        bind = ALT,Print ,exec,${system_scripts.screen_rec} full
        bind = ALT SHIFT,Print ,exec,${system_scripts.screen_rec} area
        bind =$mainMod ,Print ,exec,${system_scripts.screen_to_text}
        bind =$mainMod,B ,exec,eww open --toggle bar
        bind =$mainMod SHIFT,S , exec, ${scripts.toggle} "misc:enable_swallow" "int" "1" "0"

        #grim -g "$(slurp)" - | swappy -f - -o $HOME/pics/Screenshot/"$(date +'%Y-%m-%d_%H-%M-%S')_$(echo | tofi --prompt-text="Name: " --require-match=false --height=8% | tr " " "_")"
        bind = $mainMod, W, killactive,
        bind = $mainMod SHIFT, P ,pin

        bind = $mainMod, Z,exec, ${scripts.toggle} "cursor:zoom_factor" "float" "1.000000" "4.000000"
        bind = $mainMod ALT, X, exec , eww open --toggle bar && eww open --toggle powermenu
        bind = $mainMod SHIFT, q, exit,
        bind = $mainMod, E, exec, thunar
        bind = $mainMod, comma , exec, ${scripts.scratchpad} file_manager "kitty --class file_manager ${pkgs.yazi}/bin/yazi"
        bind = $mainMod, M , exec, ${scripts.scratchpad} music_player "kitty ${system_scripts.mpv_music_player}"
        bind = $mainMod, T, togglefloating,
        bind = $mainMod, F , fullscreen,0
        bind = $mainMod SHIFT, F, fakefullscreen,
        bind = $mainMod, space, exec, $( tofi-drun --auto-accept-single=true )
        bind = $mainMod, P, pseudo
        bind = $mainMod, s,layoutmsg, togglesplit
        # bind = $mainMod, I , exec, [workspace 1;] kitty


# GROUP
        bind = $mainMod, G, togglegroup
        bind = $mainMod SHIFT, G, moveoutofgroup
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

        bindl=,XF86AudioPlay,exec,${system_scripts.mpv_controller} toggle
        bindl=,XF86AudioPrev,exec,${system_scripts.mpv_controller} prev
        bindl=,XF86AudioNext,exec,${system_scripts.mpv_controller} next
        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        bind=$mainMod,o,submap,open

        submap=open
        bind=,Q,exec,${system_scripts.fuzzy_browser}
        bind=,Q,submap,reset
        bind=,H,exec,${system_scripts.history_browser}
        bind=,H,submap,reset
        bind=,S,exec,${pkgs.zathura}/bin/zathura /home/inferno/UoC/9ο\ Εξαμηνο/possible_courses.pdf
        bind=,S,submap,reset

        bind=,escape,submap,reset
        submap=reset


        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod SHIFT, mouse:272, resizewindow

      '';
  };
}

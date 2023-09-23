{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
    imports = [
        ./programs/tofi/tofi.nix
        ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "inferno";
  home.homeDirectory = "/home/inferno";

  programs.eww = {
      package =   pkgs.eww-wayland;
      enable = true;
      configDir = ./programs/eww;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
  };

  services.dunst = {
    enable = true;
    settings = {
      # See dunst(5) for all configuration options
      global = {
        monitor = 0;
        follow = "none";
        width = "(0, 500)";
        height = 500;
        origin = "top-right";
        offset = "10x30";
        scale = 0;
        notification_limit = 20;
        progress_bar = "true";
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 3;
        icon_corner_radius = 0;
        indicate_hidden = true;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 3;
        gap_size = 0;
        separator_color = "frame";
        sort = true;
        font = "FiraCode";
        line_height = 0;
        markup = "full";
        format = ''<big><b>%s</b></big>\n%b'';
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = "true";
        hide_duplicate_count = "false";
        show_indicators = true;
        enable_recursive_icon_lookup = "true";
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 256;
        sticky_history = true;
        history_length = 20;
        dmenu = "tofi";
        browser = "/usr/bin/xdg-open";
        always_run_script = "true";
        title = "Dunst";
        class = "Dunst";
        corner_radius = 3;
        ignore_dbusclose = "false";
        force_xwayland = "false";
        force_xinerama = "false";
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      experimental = {per_monitor_dpi = "false";};
      urgency_low = {
        background = "#222222";
        foreground = "#888888";
        timeout = 10;
      };
      urgency_normal = {
        timeout = 10;
        background = "#1E1E1E";
        foreground = "#ffffff";
        highlight = "#FFB52A";
      };
      urgency_critical = {
        background = "#1E1E1E";
        foreground = "#ffffff";
        frame_color = "#ff0000";
        timeout = 0;
      };
      transient_disable = {};
      transient_history_ignore = {};
      fullscreen_delay_everything = {};
      fullscreen_show_critical = {};
      espeak = {};
      script-test = {};
      ignore = {};
      history-ignore = {};
      skip-display = {};
      signed_on = {};
      signed_off = {};
      says = {};
      twitter = {};
      stack-volumes = {};
    };
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    vimAlias = true;
    viAlias = true;
    extraPackages = with pkgs; [gcc ripgrep fd nodejs_18];
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Lampros Pitsillos";
    userEmail = "hauahx@gmail.com";
    aliases = {
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
    };
    extraConfig = {
      credential.helper = "store";
      merge.conflictstyle = "diff3";
    };
  };

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

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  qt = {
    platformTheme = "gtk";
    enable = true;
    style.name = "adwaita";

    # detected automatically:
    # adwaita, adwaita-dark, adwaita-highcontrast,
    # adwaita-highcontrastinverse, breeze,
    # bb10bright, bb10dark, cde, cleanlooks,
    # gtk2, motif, plastique

    style.package = pkgs.adwaita-qt6;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      package = pkgs.vimix-icon-theme;
      name = "Vimix";
    };
  };
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      thumbfast
      sponsorblock
      uosc
      quality-menu
      webtorrent-mpv-hook
    ];
    defaultProfiles = [
      "gpu-hq"
    ];
    bindings = {
      "Ctrl+Alt+d" = ''run "${pkgs.trashy}/bin/trash" "''${path}"'';
      p = "playlist-prev";
      n = "playlist-next";
      l = ''cycle-values loop-playlist "inf" "no" '';
    };
    config = {
      hwdec = "auto-safe";
      hwdec-codecs = "all";
      vo = "gpu";
      sub-auto = "fuzzy";
      sub-codepage = "gbk";
      osc = "no";
      osd-bar = "no";
      border = "no";
      ytdl-format = "bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9]+bestaudio/best";
      cache = "yes";
      gpu-context = "wayland";
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-q";
    terminal = "screen-256color";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--height 40%"
      "--border"
    ];
  };
  xdg.configFile."newt/newt_colors" = {
    enable = true;
    text = ''
      root=white,black
      window=black,white
      title=black,lightgray
      label=black,lightgray
      acttextbox=white,black
      actbutton=white,black
      actlistbox=black,lightgray
      listbox=black,lightgray
      button=white,black
      actsellistbox=white,black
    '';
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    # syntaxHighlighting = {
    #   enable = true;
    #   package = pkgs.zsh-fast-syntax-highlighting;
    # };
    enableCompletion = true;
    # enableAutosuggestions = true;
    autocd = true;

    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "cf318e06a9b7c9f2219d78f41b46fa6e06011fd9";
          sha256 = "1bmrb724vphw7y2gwn63rfssz3i8lp75ndjvlk5ns1g35ijzsma5";
        };
      }
    ];
    history = {
      ignoreDups = true;
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      share = true;
      size = 9999999;
    };
    defaultKeymap = "emacs";
    shellAliases = {
      nup = "sudo nixos-rebuild switch --flake /home/inferno/.nixos-config";
      hup = "home-manager switch -b backup --flake /home/inferno/.nixos-config\#inferno";
      nconf = "nv /home/inferno/.nixos-config/nixos/configuration.nix";
      hconf = "nv /home/inferno/.nixos-config/home-manager/home.nix";

      btd = "bluetoothctl power off";
      btc = "bluetoothctl power on && bluetoothctl connect $(bluetoothctl devices | fzf --tac --reverse --height=30% --border | cut -d ' ' -f2)";
      ip = "ip -color=auto";
      # gtu = "cd ~/UoC/4ο\ Εξαμηνο";
      ls = "ls --sort time --color=auto -h";
      la = "eza --icons --long --accessed --all";
      lar = "eza --icons --long --accessed --all --tree --level ";
      tree = "eza --icons --tree --accessed";
      nv = "nvim";
      q = "exit";
      fm = "vifm .";
      se = "sudoedit";
      ytmp3 = ''
        ${lib.getExe pkgs.yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"
      '';
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";

      # GIT
      gco= "git checkout";
      gcl= "git clone";
      gdf = "git diff";
      gst = "git status";

    };
    shellGlobalAliases = {
      CP = " ${pkgs.wl-clipboard}/bin/wl-copy ";
      CPp = " ${pkgs.wl-clipboard}/bin/wl-copy --primary ";
      PT = " ${pkgs.wl-clipboard}/bin/wl-paste ";
      PTp = " ${pkgs.wl-clipboard}/bin/wl-paste --primary ";
    };
    completionInit = ''
      autoload -U compinit
       zstyle ':completion:*' menu select
       zmodload zsh/complist
       fpath=( $ZDOTDIR/completions $fpath )
       compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
       # _comp_options+=(globdots)
    '';
    initExtra =
      /*
      zsh
      */
      ''
              # https://github.com/NotAShelf/nyx/blob/6db9e9ff81376831beaf5324c6e6f60739c1b907/homes/notashelf/terminal/shell/zsh.nix#L204
              stty stop undef

              zmodload zsh/zprof
              zmodload zsh/zle
              zmodload zsh/zpty
              # zmodload zsh/complist

              autoload -Uz colors && colors

              # Group matches and describe.
              zstyle ':completion:*' sort true
              zstyle ':completion:complete:*:options' sort true
              zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
              zstyle ':completion:*' special-dirs false
              zstyle ':completion:*' rehash true

              zstyle ':completion:*' menu yes select # search
              zstyle ':completion:*' verbose yes
              zstyle ':completion:*:matches' group 'yes'
              zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
              zstyle ':completion:*:messages' format '%d'
              zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

        LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:';
        export LS_COLORS

              zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

                  # Fuzzy match mistyped completions.
                    zstyle ':completion:*' completer _complete _match _approximate
                    zstyle ':completion:*:match:*' original only
                    zstyle ':completion:*:approximate:*' max-errors 1 numeric

                # Don't complete unavailable commands.
                    zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

                 # Autosuggest
                    ZSH_AUTOSUGGEST_USE_ASYNC="true"

        autoload -U up-line-or-beginning-search
        autoload -U down-line-or-beginning-search
        zle -N up-line-or-beginning-search
        zle -N down-line-or-beginning-search

              bindkey '^[k' history-substring-search-up
              bindkey '^[j' history-substring-search-down
              bindkey '^k' up-line-or-beginning-search
              bindkey '^j' down-line-or-beginning-search
              bindkey -M menuselect '^j' vi-down-line-or-history
              bindkey -M menuselect '^k' vi-up-line-or-history
              bindkey -M menuselect '^h' vi-backward-char
              bindkey -M menuselect '^l' vi-forward-char


              setopt AUTO_LIST AUTO_LIST AUTO_MENU \
              AUTO_PARAM_SLASH AUTO_PUSHD APPEND_HISTORY \
              ALWAYS_TO_END COMPLETE_IN_WORD CORRECT EXTENDED_HISTORY \
              HIST_FCNTL_LOCK \
              HIST_REDUCE_BLANKS HIST_VERIFY INC_APPEND_HISTORY \
              INTERACTIVE_COMMENTS MENU_COMPLETE NO_NOMATCH PUSHD_IGNORE_DUPS \
              PUSHD_TO_HOME PUSHD_SILENT SHARE_HISTORY
              unsetopt CORRECT_ALL HIST_BEEP MENU_COMPLETE

        function uzip() {unzip "$1" -d "$1%.*" }
        function mkcd () { mkdir -p $1 && cd ./$1 }
        function cwd () { echo -ne "\"$(pwd)\"" | wl-copy }

        eval "$(starship init zsh )"

              # zprof
      '';
  };

  programs.qutebrowser = {
    enable = false;
    aliases = {
      w = "session-save";
      q = "close";
      qa = "quit";
      wq = "quit --save";
      wqa = "quit --save";
    };
    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
      y = "https://www.youtube.com/results?search_query={}";
      n = "https://search.nixos.org/packages?channel=23.05&from=0&size=50&sort=relevance&type=packages&query={} ";
      gt = "https://github.com/search?q={}";
      g = "https://www.google.com/search?q={}";
      st = "https://stackoverflow.com/search?q={}";
      CPP = "https://duckduckgo.com/?sites=cppreference.com&q={}";
    };
    settings = let
      background = "#1c1c1c";
      background-alt = "#161616";
      background-attention = "#181920";
      border = "#282a36";
      gray = "#909497";
      selection = "#333333";
      foreground = "#f8f8f2";
      foreground-alt = "#e0e0e0";
      foreground-attention = "#ffffff";
      comment = "#6272a4";
      cyan = "#8be9fd";
      green = "#50fa7b";
      orange = "#ffb86c";
      pink = "#ff79c6";
      brown = "#ffaf00";
      purple = "#bd93f9";
      red = "#ff5555";
      yellow = "#f1fa8c";
      none = "none";
    in {
      colors = {
        completion = {
          category = {
            bg = background;
            border = {
              bottom = border;
              top = border;
            };
            fg = foreground;
          };
          even = {
            bg = background;
          };
          fg = foreground;
          item = {
            selected = {
              bg = selection;
              border = {
                bottom = selection;
                top = selection;
              };
              fg = foreground;
            };
          };
          match = {
            fg = orange;
          };
          odd = {
            bg = background-alt;
          };
          scrollbar = {
            bg = background;
            fg = foreground;
          };
        };
        downloads = {
          bar = {
            bg = background;
          };
          error = {
            bg = background;
            fg = red;
          };
          stop = {
            bg = background;
          };
          system = {
            bg = none;
          };
        };
        hints = {
          bg = background;
          fg = foreground-attention;
          match = {
            fg = foreground-alt;
          };
        };
        keyhint = {
          bg = background;
          fg = gray;
          suffix = {
            fg = foreground-attention;
          };
        };
        messages = {
          error = {
            bg = background;
            border = background-alt;
            fg = red;
          };
          info = {
            bg = background;
            border = background-alt;
            fg = foreground-attention;
          };
          warning = {
            bg = background;
            border = background-alt;
            fg = red;
          };
        };
        prompts = {
          bg = background;
          border = "1px solid  + ${background};";
          fg = orange;
          selected = {
            bg = selection;
          };
        };
        statusbar = {
          caret = {
            bg = background;
            fg = orange;
            selection = {
              bg = background;
              fg = orange;
            };
          };
          command = {
            bg = background;
            fg = brown;
            private = {
              bg = background;
              fg = foreground-alt;
            };
          };
          insert = {
            bg = background-attention;
            fg = foreground-attention;
          };
          normal = {
            bg = background;
            fg = foreground;
          };
          passthrough = {
            bg = background;
            fg = orange;
          };
          private = {
            bg = background-alt;
            fg = foreground-alt;
          };
          progress = {
            bg = background;
          };
          url = {
            error = {
              fg = red;
            };
            fg = foreground;
            hover = {
              fg = cyan;
            };
            success = {
              http = {
                fg = green;
              };
              https = {
                fg = green;
              };
            };
            warn = {
              fg = yellow;
            };
          };
        };
        tabs = {
          bar = {
            bg = selection;
          };
          even = {
            bg = selection;
            fg = foreground;
          };
          indicator = {
            error = red;
            start = orange;
            stop = green;
            system = none;
          };
          odd = {
            bg = selection;
            fg = foreground;
          };
          selected = {
            even = {
              bg = background;
              fg = brown;
            };
            odd = {
              bg = background;
              fg = brown;
            };
          };
        };
        down = {
          system = {
            bg = none;
          };
        };
      };
      hints = {
        border = "1px solid  + ${background-alt};";
      };
      tabs = {
        favicons = {
          scale = 1;
        };
        indicator = {
          width = 1;
        };
      };
    };
  };

  # SCRIPTS
  programs.zathura = {
      enable = true;
      mappings = {

          };
          options = {
 notification-error-bg =      "#ff5555"; # Red
 notification-error-fg =      "#f8f8f2"; # Foreground
 notification-warning-bg =    "#ffb86c"; # Orange
 notification-warning-fg =    "#22222a"; # Selection
 notification-bg =            "#222222"; # Background
 notification-fg =            "#f8f8f2"; # Foreground

 completion-bg =              "#1e1e1e"; # Background
 completion-fg =              "#666666"; # Comment
 completion-group-bg =        "#1e1e1e"; # Background
 completion-group-fg =        "#666666"; # Comment
 completion-highlight-bg =    "#303030"; # Selection
 completion-highlight-fg =    "#f8f8f2"; # Foreground

 index-bg =                   "#1e1e1e"; # Background
 index-fg =                   "#f8f8f2"; # Foreground
 index-active-bg =            "#222222"; # Current Line
 index-active-fg =            "#f8f8f2"; # Foreground

 inputbar-bg =                "#222222"; # Background
 inputbar-fg =                "#f8f8f2"; # Foreground
 statusbar-bg =               "#1e1e1e"; # Background
 statusbar-fg =               "#f8f8f2"; # Foreground

 highlight-color =            "#4B69B5"; # Blue
 highlight-active-color =     "#ff79c6"; # Pink

 default-bg =                 "#1e1e1e"; # Background
 default-fg =                 "#f8f8f2"; # Foreground

 render-loading              =true;
 render-loading-fg =          "#1e1e1e"; # Background
 render-loading-bg =          "#f8f8f2"; # Foreground

adjust-open ="width";

pages-per-row =1;

scroll-page-aware ="true";
scroll-full-overlap ="0.01";
scroll-step =40;
sandbox ="none";
window-title-basename =true;
incremental-search =true;
font ="JetBrainsMono NF bold 10";
statusbar-home-tilde ="true";
first-page-column ="1:1";
              };

      };

  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerdfonts;
      name = "JetBrainsMono NF";
      size = 12;
    };
    keybindings = {
      "kitty_mod+s" = "paste_from_clipboard";
      "kitty_mod+v" = "paste_from_selection";
    };
    extraConfig = ''
      modify_font underline_position 2
      modify_font underline_thickness 200%

      modify_font cell_width 100%
      modify_font cell_height -1px
    '';
    settings = {
      disable_ligatures = "cursor";
      # scrollback_pager = ''
      # bash -c "exec nvim 63<&0 0</dev/null -u NONE -c 'map <silent> q :qa!<CR>' -c 'map <silent> i :qa!<CR>' -c 'set shell=bash scrollback=100000 termguicolors laststatus=0 cmdheight=0 noruler noshowmode noshowcmd clipboard+=unnamed' -c 'autocmd TermEnter * stopinsert' -c 'autocmd TermClose * call cursor(max([0,INPUT_LINE_NUMBER-1])+CURSOR_LINE, CURSOR_COLUMN)' -c 'terminal sed </dev/fd/63 -e \"s/'$'\x1b'']8;;file:[^\]*[\]//g\" && sleep 0.01 && printf \"'$'\x1b'']2;\"'"
      # '';
      copy_on_select = true;
      enable_audio_bell = false;
      window_alert_on_bell = false;
      bell_on_tab = false;
      window_margin_width = 0;
      background_opacity = 1;
      allow_remote_control = true;
    };

    shellIntegration.enableZshIntegration = true;
    theme = "One Half Dark";
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/inferno/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    NEWT_COLORS_FILE = lib.mkIf config.xdg.configFile."newt/newt_colors".enable "${config.xdg.configHome}/newt/newt_colors";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
# saiw{F{i$wipkgs.f}a/bin/F.lywg;p


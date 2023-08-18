{
  lib,
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "inferno";
  home.homeDirectory = "/home/inferno";

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
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
    package = pkgs.hyprland;
    enableNvidiaPatches = true;
    xwayland.enable = true;

    enable = false;
    settings = {
      monitor = [
        "eDP-1,1920x1080,0x0 ,1"
        ",preferred,auto,1 "
      ];

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "caps:escape";
        kb_rules = "";
        numlock_by_default = "true";
        repeat_rate = 50;
        repeat_delay = 250;
        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 3;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(FFB53AEE) rgba(EF990EEE) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      exec-once = [
        "${pkgs.hyprpaper}/bin/hyprpaper &"
        "${pkgs.eww-wayland}/bin/eww  open bar & "

        "${pkgs.hyprland}/bin/hyprctl  setcursor 'Bibata-Modern-Ice' 10"
      ];

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 0;
        blur = true;
        blur_size = 3;
        blur_passes = 1;
        blur_new_optimizations = "on";
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = " myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          " windows, 1, 2, myBezier"
          " windowsOut, 1, 2, default, popin 80%"
          " border, 1, 10, default"
          " borderangle, 1, 8, default"
          " fade, 1 , 1, default"
          "workspaces, 1, 4, default"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = false;
        workspace_swipe_cancel_ratio = 0;
      };

      "device:epic mouse V1" = {
        sensitivity = -0.5;
      };

      "$Mod" = "SUPER";

      bind = [
        '',Print, exec, ${lib.getExe pkgs.grim} -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f - ''

        # ",XF86AudioPlay,exec,"
        # ",XF86AudioPause,exec,"
        # ",XF86AudioPrev,exec,"
        # ",XF86AudioNext,exec,"
        # ",XF86AudioMute,exec,"
        # ",XF86MonBrightnessUp,exec,"
        # ",XF86MonBrightnessDown,exec,"
        # ",XF86AudioRaiseVolume,exec,"
        # ",XF86AudioLowerVolume,exec,"

        "$Mod,return, exec, ${pkgs.kitty}/bin/kitty"
        "$Mod, W, killactive, "
        "$Mod SHIFT, q, exit, "
        "$Mod, E, exec, ${pkgs.xfce.thunar}/bin/thunar "
        "$Mod, V, togglefloating, "
        "$Mod, space, exec, ${pkgs.tofi}/bin/tofi-drun  "
        "$Mod, P, pseudo, " # dwindle
        "$Mod, s, togglesplit," # dwindle

        # Move focus with Mod + arrow keys
        "$Mod, h, movefocus, l"
        "$Mod, l, movefocus, r"
        "$Mod, k, movefocus, u"
        "$Mod, j, movefocus, d"

        # Switch workspaces with Mod + [0-9]
        "$Mod, 1, workspace, 1"
        "$Mod, 2, workspace, 2"
        "$Mod, 3, workspace, 3"
        "$Mod, 4, workspace, 4"
        "$Mod, 5, workspace, 5"
        "$Mod, 6, workspace, 6"
        "$Mod, 7, workspace, 7"
        "$Mod, 8, workspace, 8"
        "$Mod, 9, workspace, 9"
        "$Mod, 0, workspace, 10"

        # Move active window to a workspace with Mod + SHIFT + [0-9]
        "$Mod SHIFT, 1, movetoworkspace, 1"
        "$Mod SHIFT, 2, movetoworkspace, 2"
        "$Mod SHIFT, 3, movetoworkspace, 3"
        "$Mod SHIFT, 4, movetoworkspace, 4"
        "$Mod SHIFT, 5, movetoworkspace, 5"
        "$Mod SHIFT, 6, movetoworkspace, 6"
        "$Mod SHIFT, 7, movetoworkspace, 7"
        "$Mod SHIFT, 8, movetoworkspace, 8"
        "$Mod SHIFT, 9, movetoworkspace, 9"
        "$Mod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with Mod + scroll
        "$Mod, mouse_down, workspace, e+1"
        "$Mod, mouse_up, workspace, e-1"
      ];

      #$Mod, mouse:273, resizewindow Move/resize windows with Mod + LMB/RMB and dragging
      bindm = [
        "$Mod, mouse:272, movewindow"
        "$Mod, mouse:273, resizewindow"
      ];
    };
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
    style.name = "gtk2";

    # detected automatically:
    # adwaita, adwaita-dark, adwaita-highcontrast,
    # adwaita-highcontrastinverse, breeze,
    # bb10bright, bb10dark, cde, cleanlooks,
    # gtk2, motif, plastique

    style.package = pkgs.adwaita-qt;
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
      # visualizer
      webtorrent-mpv-hook
    ];
    defaultProfiles = [
      "gpu-hq"
    ];
    config = {
      hwdec = "auto-safe";
      vo="gpu";
      sub-auto = "fuzzy";
      sub-codepage = "gbk";
      osc = "no";
      osd-bar = "no";
      border = "no";
      ytdl-format = "bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9]+bestaudio/best";
      cache = "yes";
      gpu-context= "wayland";
    };
  };

programs.fzf = {
enable =true;
enableZshIntegration=true;
defaultCommand = "fd --type f";
defaultOptions = [
  "--height 40%" 
  "--border" 
];

};
  xdg.configFile."newt/newt_colors"= {
      enable=true;
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
      la = "exa --icons --long --accessed --all";
      lar = "exa --icons --long --accessed --all --tree --level ";
      tree = "exa --icons --tree --accessed";
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
    };
    completionInit = ''
      autoload -U compinit
         zstyle ':completion:*' menu select
         zmodload zsh/complist
         compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
         _comp_options+=(globdots)
    '';
    initExtra = ''
            # https://github.com/NotAShelf/nyx/blob/6db9e9ff81376831beaf5324c6e6f60739c1b907/homes/notashelf/terminal/shell/zsh.nix#L204
            stty stop undef


            zmodload zsh/zle
            zmodload zsh/zpty
            zmodload zsh/complist

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
            HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE \
            HIST_REDUCE_BLANKS HIST_VERIFY INC_APPEND_HISTORY \
            INTERACTIVE_COMMENTS MENU_COMPLETE NO_NOMATCH PUSHD_IGNORE_DUPS \
            PUSHD_TO_HOME PUSHD_SILENT SHARE_HISTORY
            unsetopt CORRECT_ALL HIST_BEEP MENU_COMPLETE

      function uzip() {unzip "$1" -d "$1%.*" }
      function mkcd () { mkdir -p $1 && cd ./$1 }
      function cwd () { echo -ne "\"$(pwd)\"" | wl-copy }

      eval "$(starship init zsh )"
    '';
  };

  programs.qutebrowser = {
      enable = false;
      aliases  = {
    w= "session-save";
    q= "close";
    qa= "quit";
    wq= "quit --save";
    wqa= "quit --save";
      };
      searchEngines = {

          DEFAULT= "https://duckduckgo.com/?q={}";
          y= "https://www.youtube.com/results?search_query={}";
          n= "https://search.nixos.org/packages?channel=23.05&from=0&size=50&sort=relevance&type=packages&query={} ";
          gt= "https://github.com/search?q={}";
          g= "https://www.google.com/search?q={}";
          st="https://stackoverflow.com/search?q={}";
          CPP="https://duckduckgo.com/?sites=cppreference.com&q={}";
      };
settings = let 
   background= "#1c1c1c";
    background-alt= "#161616";
    background-attention= "#181920";
    border= "#282a36";
    gray= "#909497";
    selection= "#333333";
    foreground= "#f8f8f2";
    foreground-alt= "#e0e0e0";
    foreground-attention= "#ffffff";
    comment= "#6272a4";
    cyan= "#8be9fd";
    green= "#50fa7b";
    orange= "#ffb86c";
    pink= "#ff79c6";
    brown= "#ffaf00";
    purple= "#bd93f9";
    red= "#ff5555";
    yellow= "#f1fa8c";
    none = "none";
  in
{
  colors= {
    completion= {
      category= {
        bg= background;
        border= {
          bottom= border;
          top= border;
        };
        fg= foreground;
      };
      even= {
        bg= background;
      };
      fg= foreground;
      item= {
        selected= {
          bg= selection;
          border= {
            bottom= selection;
            top= selection;
          };
          fg= foreground;
        };
      };
      match= {
        fg= orange;
      };
      odd= {
        bg= background-alt;
      };
      scrollbar= {
        bg= background;
        fg= foreground;
      };
    };
    downloads= {
      bar= {
        bg= background;
      };
      error= {
        bg= background;
        fg= red;
      };
      stop= {
        bg= background;
      };
      system= {
        bg= none;
      };
    };
    hints= {
      bg= background;
      fg= foreground-attention;
      match= {
        fg= foreground-alt;
      };
    };
    keyhint= {
      bg= background;
      fg= gray;
      suffix= {
        fg= foreground-attention;
      };
    };
    messages= {
      error= {
        bg= background;
        border= background-alt;
        fg= red;
      };
      info= {
        bg= background;
        border= background-alt;
        fg= foreground-attention;
      };
      warning= {
        bg= background;
        border= background-alt;
        fg= red;
      };
    };
    prompts= {
      bg= background;
      border= "1px solid  + ${ background };";
      fg= orange;
      selected= {
        bg= selection;
      };
    };
    statusbar= {
      caret= {
        bg= background;
        fg= orange;
        selection= {
          bg= background;
          fg= orange;
        };
      };
      command= {
        bg= background;
        fg= brown;
        private= {
          bg= background;
          fg= foreground-alt;
        };
      };
      insert= {
        bg= background-attention;
        fg= foreground-attention;
      };
      normal= {
        bg= background;
        fg= foreground;
      };
      passthrough= {
        bg= background;
        fg= orange;
      };
      private= {
        bg= background-alt;
        fg= foreground-alt;
      };
      progress= {
        bg= background;
      };
      url= {
        error= {
          fg= red;
        };
        fg= foreground;
        hover= {
          fg= cyan;
        };
        success= {
          http= {
            fg= green;
          };
          https= {
            fg= green;
          };
        };
        warn= {
          fg= yellow;
        };
      };
    };
    tabs= {
      bar= {
        bg= selection;
      };
      even= {
        bg= selection;
        fg= foreground;
      };
      indicator= {
        error= red;
        start= orange;
        stop= green;
        system= none;
      };
      odd= {
        bg= selection;
        fg= foreground;
      };
      selected= {
        even= {
          bg= background;
          fg= brown;
        };
        odd= {
          bg= background;
          fg= brown;
        };
      };
    };
    down = {
      system= {
        bg= none;
      };
    };
  };
  hints= {
    border= "1px solid  + ${background-alt};";
  };
  tabs= {
    favicons= {
      scale= 1;
    };
    indicator= {
      width= 1;
    };
  };
};
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
      NEWT_COLORS_FILE = lib.mkIf config.xdg.configFile."newt/newt_colors".enable  "${ config.xdg.configHome }/newt/newt_colors" ;

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
# saiw{F{i$wipkgs.f}a/bin/F.lywg;p


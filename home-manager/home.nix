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
  programs.mpv= {
      enable=true;
      scripts = with pkgs.mpvScripts; [
              thumbfast
              sponsorblock
              uosc
                quality-menu
                visualizer
                webtorrent-mpv-hook
      ];
defaultProfiles = [
"gpu-hq"
];
config = {
 hwdec = "auto";
 sub-auto = "fuzzy";
        sub-codepage = "gbk";
        osc = "no";
        osd-bar = "no";
        border = "no";
        ytdl-format="bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9]+bestaudio/best";
        cache-default = 4000000;
};
  };
  programs.zsh = {
    enable = false;
    dotDir = config.xdg.configHome/zsh;
    syntaxHighlighting={
        enable=true;
        package = pkgs.zsh-fast-syntax-highlighting;

    };
    enableCompletion = true;
    # enableAutosuggestions = true;


    history = {
      ignoreDups = true;
      ignoreSpace = true;
      path = config.xdg.dataHome/zsh/zsh_history;
      share = true;
    };
    shellAliases = {
      btd = "bluetoothctl power off";
      btc = "bluetoothctl power on && bluetoothctl connect $(bluetoothctl devices | fzf --tac --reverse --height=30% --border | cut -d " " -f2)";
      ip = "ip -color=auto";
      Rcp = "rsync --human-readable --progress --whole-file --archive";
      conf = "nvim /home/inferno/.config/zsh/.zsh_aliases_functions";
      gtd = "cd ~/downs && ls";
      gtp = "cd ~/pics/";
      gtdo = "cd ~/docs/";
      gtu = "cd ~/UoC/4ο\ Εξαμηνο";
      ls = "ls --sort time --color=auto -h";
      la = "exa --icons --long --accessed --all";
      lar = "exa --icons --long --accessed --all --tree --level ";
      tree = "exa --icons --tree --accessed";
      nconf = "nvim $HOME/.config/nvim/init.lua";
      nv = "nvim";
      q = "exit";
      fm = "vifm .";
      se = "sudoedit";
    };
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

      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "75094d7275d58229bc1c92587d352dd116e25b3c";
          sha256 = "0dca09g97a33nrsdinahznh6y04ir0i4vd2pcc59crmmz215gawq";
        };
      }
    ];
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
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
# saiw{F{i$wipkgs.f}a/bin/F.lywg;p


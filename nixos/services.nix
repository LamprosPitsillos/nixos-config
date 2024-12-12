{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  services = {
    upower = {
      enable = true;
    };
    mysql = {
      enable = false;
      package = pkgs.mariadb;
    };

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

    syncthing = {
      enable = true;
    };

    kanata = {
      enable = true;
      keyboards = {
        "homerow" = {
          devices = [];
          config =
            /*
            clojure
            */
            ''
              (defsrc
               esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 prnt slck del home pgup pgdn end
               `       1    2    3    4    5    6    7    8    9    0    -    =    bspc
               tab     q    w    e    r    t    y    u    i    o    p    [    ]    \
               caps    a    s    d    f    g    h    j    k    l    ;    '    ret
               lsft      z    x    c    v    b    n    m    ,    .    /    rsft       up
               lctl    lmet lalt           spc            ralt cmp  rctl        left down rght
              )

              (defalias
               num   (layer-while-held nums) ;; Bind 'num' to numpad Layer
               esc_ctrl   (tap-hold 200 200 esc lctl);; Bind esc to Ctrl when holding
              )

              (deflayer qwerty
               caps     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 prnt slck del home pgup pgdn end
               `       1    2    3    4    5    6    7    8    9    0    -    =    bspc
               tab     q    w    e    r    t    y    u    i    o    p    [    ]    \
               @esc_ctrl    a    s    d    f    g    h    j    k    l    ;    '    ret
               lsft      z    x    c    v    b    n    m    ,    .    /    rsft       up
               lctl    lmet lalt           spc            @num cmp  rctl        left down rght
              )

              (deflayer nums
               _     _   _   _   _   _   _   _   _   _   _  _  _ _ _ _ _ _ _ _
               _   _    _    _    _    _    _    _    _    _    _     _    _    _
               _   S-1    S-2    S-3    S-4    S-5    S-6    S-7    S-8    S-9    S-0    _    _    _
               _   1    2    3    4    5    6    7    8    9    0   _    _
               _   _    _    _    _    _    _    -    =    _    _        _       _
               _    _  bspc                 ret              _ _  _        _ _ _

              )
            '';
        };
      };
    };

      displayManager = {
        sddm = {
          enable = true;
          autoNumlock = true;
          theme = "chili";
          extraPackages = with pkgs; [
            elegant-sddm
            sddm-chili-theme

            libsForQt5.qt5.qtquickcontrols
          ];
        };
      };
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "caps:escape";
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber = {
        configPackages = [
          (
            pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua"
            /*
            lua
            */
            ''
              bluez_monitor.properties = {
                  ["bluez5.enable-sbc-xq"] = true,
                  ["bluez5.enable-msbc"] = true,
                  ["bluez5.enable-hw-volume"] = true,
                  ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
              }
            ''
          )
        ];
      };
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
    xserver.videoDrivers = ["nvidia"];
    libinput.enable = true;

    # File system browsing deps
    gvfs.enable = true;
    tumbler.enable = true;
    udisks2.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;
    printing.enable = true;
  };
  security = {
    polkit = {
      enable = true;
      # extraConfig = ''
      #   polkit.addRule(function(action, subject) {
      #     var YES = polkit.Result.YES;
      #     var permission = {
      #       // required for udisks1:
      #       "org.freedesktop.udisks.filesystem-mount": YES,
      #       "org.freedesktop.udisks.luks-unlock": YES,
      #       "org.freedesktop.udisks.drive-eject": YES,
      #       "org.freedesktop.udisks.drive-detach": YES,
      #       // required for udisks2:
      #       "org.freedesktop.udisks2.filesystem-mount": YES,
      #       "org.freedesktop.udisks2.encrypted-unlock": YES,
      #       "org.freedesktop.udisks2.eject-media": YES,
      #       "org.freedesktop.udisks2.power-off-drive": YES,
      #       // required for udisks2 if using udiskie from another seat (e.g. systemd):
      #       "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
      #       "org.freedesktop.udisks2.filesystem-unmount-others": YES,
      #       "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
      #       "org.freedesktop.udisks2.encrypted-unlock-system": YES,
      #       "org.freedesktop.udisks2.eject-media-other-seat": YES,
      #       "org.freedesktop.udisks2.power-off-drive-other-seat": YES
      #     };
      #     if (subject.isInGroup("storage")) {
      #       return permission[action.id];
      #     }
      #   });
      # '';
    };

    pam.services.gtklock = {};
    rtkit.enable = true;
  };
}

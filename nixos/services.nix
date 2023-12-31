{ config
, pkgs
, inputs
, lib
, ...
}: {
  services = {
    mysql = {
      enable = true;
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
          devices = [ ];
          config = ''
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
             _   _    _    -    =    _    _    [    ]    \    _    _    _    _
             _   1    2    3    4    5    6    7    8    9    0   _    _
             _   _    _    _    _    _    _    _    _    _    _    _       _
             _    _  bspc                 ret              _ _  _        _ _ _

            )
          '';
        };
      };
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "caps:escape";
      displayManager = {
        sddm = {
          enable = true;
          autoNumlock = true;
          theme = "chili";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
    xserver.videoDrivers = [ "nvidia" ];
    xserver.libinput.enable = true;

    # File system browsing deps
    gvfs.enable = true;
    tumbler.enable = true;
    udisks2.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;
    printing.enable = true;
  };
  security = {
    polkit.enable = true;
    pam.services.gtklock = { };
    rtkit.enable = true;
  };
}

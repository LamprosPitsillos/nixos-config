# NIXOS
- Secrets
- Split config to:
    - HomeLab
    - Inferno

## Neovim
It has been almost a year since I modified my config in a significant way
These are the changes am looking for:
- Proper Debuging support
- LLM integration
    Since I do sometimes use LLMS I prefer to not leave my editor and have to copy paste stuff
- Ease of Life
    - `statuscolumn`
        - git signs
        - debbug signs
        - relative numbers in all modes except cmdline mode ( for ex commands )


## HomeLab
The main point of the homelab will be to learn and experiment, thats why I will be using programs that are considered industry standards (nginx, dockers) instead of native NixOs modules hiding complexity

I want to selfhost:
    - NAS
    - [Home Assistant](https://www.home-assistant.io/installation/alternative#docker-compose)
    - [Immich](https://github.com/immich-app/immich)
    - [PenPot](https://help.penpot.app/technical-guide/getting-started/docker/#example-with-caddy-server)
    - [PiHole](https://github.com/pi-hole/docker-pi-hole/#running-pi-hole-docker)


flake.lock
flake.nix
home-manager
├── home.nix
├── programs
│   ├── dunst
│   │   └── dunst.nix
│   ├── file_manager
│   │   └── yazi.nix
│   ├── media
│   │   ├── image
│   │   │   └── ipqv.nix
│   │   └── record
│   │       └── obs.nix
│   ├── mpv
│   │   └── mpv.nix
│   ├── nvim
│   ├── qutebrowser
│   │   └── qutebrowser.nix
│   ├── shell
│   │   ├── fish.nix
│   │   ├── nush.nix
│   │   └── zsh.nix
│   ├── starship
│   │   └── starship.nix
│   ├── terminal
│   │   ├── alacritty.nix
│   │   ├── ghostty.nix
│   │   ├── kitty.nix
│   │   ├── tmux.nix
│   │   └── wezterm.nix
│   ├── tofi
│   │   └── tofi.nix
│   ├── vcs
│   │   ├── git.nix
│   │   └── jujutsu.nix
│   ├── widgets
│   │   ├── ags
│   │   │   ├── ags.nix
│   │   │   └── config
│   │   │       ├── app.ts
│   │   │       ├── env.d.ts
│   │   │       ├── package.json
│   │   │       ├── style.scss
│   │   │       ├── tsconfig.json
│   │   │       └── widget
│   │   │           └── Bar.tsx
│   │   └── eww
│   │       ├── eww.nix
│   ├── wm
│   │   ├── hypridle.nix
│   │   ├── hyprland.nix
│   │   ├── hyprlock.nix
│   │   ├── hyprpaper.nix
│   │   └── scripts.nix
│   └── zathura
│       └── zathura.nix
└── wsl.nix
LICENSE
nixos
├── configuration.nix
├── hardware-configuration.nix
├── homelab-hardware-configuration.nix
├── nix.nix
├── services.nix
└── wsl-configuration.nix
README.md
REWRITETODO.md
scripts
├── default.nix
└── web.nix
templates
├── default
│   └── flake.nix
└── python
    └── flake.nix

{lib, ...}: {
  programs.qutebrowser = {
    enable = true;
    aliases = {
      w = "session-save";
      q = "close";
      qa = "quit";
      wq = "quit --save";
      wqa = "quit --save";
    };
    quickmarks = {
      csd-drive = "https://drive.google.com/drive/folders/0BxJ7tJ9gxdDdMzVhRVZ6X3hyTG8";
      elearn = "https://elearn.uoc.gr/?";
      csd = "https://www.csd.uoc.gr/";
      youtube = "https://www.youtube.com/";
      facebook = "https://www.facebook.com/messages/";
      search = "https://www.google.com/";
      gh = "https://github.com/";
      reddit = "https://www.reddit.com/";
      anime = "https://nyaa.si/";
      matrix_calc = "https://matrixcalc.org/en/";
      gpt = "https://chat.openai.com/chat";
      papersSav = "https://www.researchgate.net/profile/Anthony-Savidis";
      ascii = "https://textart.sh/";
      noogle = "https://noogle.dev/";
      nix = "https://ayats.org/";
      aps = "https://github.com/sxyazi/yazi/wiki";
    };
    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
      y = "https://www.youtube.com/results?search_query={}";
      n = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={} ";
      gh = "https://github.com/search?q={}";
      g = "https://www.google.com/search?q={}";
      CPP = "https://duckduckgo.com/?sites=cppreference.com&q={}";
      nix = "https://github.com/search?q=repo%3ANixOS%2Fnixpkgs+{}&type=pullrequests";
    };

    extraConfig =
      /*
      python
      */
      ''
        c.completion.height = "35%"
        c.confirm_quit = ["always"]
        c.content.javascript.clipboard = "access-paste"
        c.content.blocking.method = "both"
        c.editor.command = ["kitty", "nvim" ,"{}"]
        c.fonts.default_family="JetBrainsMono"
        c.fonts.tabs.selected = "default_size default_family Bold"
        c.fonts.completion.entry = "default_size default_family Bold"
        c.fonts.tabs.unselected = "default_size default_family Bold"
        c.scrolling.smooth = True
        c.spellcheck.languages = ["el-GR" ,"en-US"]
        c.statusbar.show = "always"
        c.tabs.title.format = "{index}: {current_title} {audio}{private}"
        c.tabs.show = "multiple"
        c.tabs.background = True
        c.zoom.mouse_divider = 10

        c.content.blocking.adblock.lists = [
            "https://easylist.to/easylist/easylist.txt",
            "https://easylist.to/easylist/easyprivacy.txt",
            "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
            "https://easylist.to/easylist/fanboy-annoyance.txt",
            "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
        ]
        c.content.blocking.method = "both"

        config.unbind("d", mode="normal")
      '';

    keyBindings = let
      leader = ",";
    in {
      normal = {
        "${leader}D" = "open -t https://www.dictionary.com/browse/{primary}";
        "${leader}T" = "open -t https://translate.google.com/?sl=en&tl=el&text={primary}%0A&op=translate";

        "${leader}m" = "hint links spawn --detach mpv --ytdl --no-video --force-window=immediate {hint-url}";
        "${leader}dm" = ''hint links spawn --verbose yt-dlp -x {hint-url} --embed-thumbnail --embed-metadata --audio-format mp3 --audio-quality 0 -o "$HOME/music/%(artist)s/%(title)s.%(ext)s" '';
        "${leader}M" = "spawn --detach --verbose mpv --ytdl --no-video --force-window=immediate {url}";
        "${leader}dM" = ''spawn --verbose yt-dlp -x {url} --embed-thumbnail --embed-metadata --audio-format mp3 --audio-quality 0 -o "$HOME/music/%(artist)s/%(title)s.%(ext)s"'';

        "${leader}v" = "hint links spawn --detach mpv --ytdl --force-window=immediate {hint-url}";
        "${leader}dv" = "hint links spawn --verbose yt-dlp {hint-url} --embed-thumbnail -o ~/vids/%(title)s.%(ext)s";
        "${leader}V" = "spawn --detach --verbose mpv --ytdl --force-window=immediate {url}";
        "${leader}dV" = "spawn --verbose yt-dlp {url} --embed-thumbnail -o ~/vids/%(title)s.%(ext)s";

        "${leader}P" = "open -p";
        "${leader}p" = "hint links run open -p {hint-url}";

        "${leader}c" = "spawn --userscript credentials.sh";
        "${leader}y" = "open -t -- y {primary}";

        "<Alt+h>" = "tab-prev";
        "<Alt+l>" = "tab-next";
        "<Ctrl+o>f" = "open -t www.facebook.com/messages/";
        "<Ctrl+o>g" = "open -t www.github.com";
        "<Ctrl+o>y" = "open -t www.youtube.com";
        "?" = "search {primary}";
        "I" = "hint inputs";
        "W" = "hint all window";
        "cb" = "set colors.webpage.bg white";
        "dd" = "tab-close";

        "ec" = "config-edit";
        "es" = "spawn kitty nvim /tmp/qute_sel -c 'norm p'";
        "eu" = "edit-url";

        "py" = "open -- y {primary}";
        "sp" = "set-cmd-text :print --pdf ~/downs/";
        "yY" = "yank";
        "yy" = "yank -s";
      };
      insert = {
        "<Escape>" = "mode-leave ;; jseval -q document.activeElement.blur()";
      };
      command = {
        "<Ctrl-j>" = "completion-item-focus next";
        "<Ctrl-k>" = "completion-item-focus prev";
      };
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
}

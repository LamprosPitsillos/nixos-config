{...}:{
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
    }

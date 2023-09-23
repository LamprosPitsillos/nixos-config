{...}: {
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
}

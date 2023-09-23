{...}: {
  programs.zathura = {
    enable = true;
    mappings = {
    };
    options = {
      notification-error-bg = "#ff5555"; # Red
      notification-error-fg = "#f8f8f2"; # Foreground
      notification-warning-bg = "#ffb86c"; # Orange
      notification-warning-fg = "#22222a"; # Selection
      notification-bg = "#222222"; # Background
      notification-fg = "#f8f8f2"; # Foreground

      completion-bg = "#1e1e1e"; # Background
      completion-fg = "#666666"; # Comment
      completion-group-bg = "#1e1e1e"; # Background
      completion-group-fg = "#666666"; # Comment
      completion-highlight-bg = "#303030"; # Selection
      completion-highlight-fg = "#f8f8f2"; # Foreground

      index-bg = "#1e1e1e"; # Background
      index-fg = "#f8f8f2"; # Foreground
      index-active-bg = "#222222"; # Current Line
      index-active-fg = "#f8f8f2"; # Foreground

      inputbar-bg = "#222222"; # Background
      inputbar-fg = "#f8f8f2"; # Foreground
      statusbar-bg = "#1e1e1e"; # Background
      statusbar-fg = "#f8f8f2"; # Foreground

      highlight-color = "#4B69B5"; # Blue
      highlight-active-color = "#ff79c6"; # Pink

      default-bg = "#1e1e1e"; # Background
      default-fg = "#f8f8f2"; # Foreground

      render-loading = true;
      render-loading-fg = "#1e1e1e"; # Background
      render-loading-bg = "#f8f8f2"; # Foreground

      adjust-open = "width";

      pages-per-row = 1;

      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = 40;
      sandbox = "none";
      window-title-basename = true;
      incremental-search = true;
      font = "JetBrainsMono NF bold 10";
      statusbar-home-tilde = "true";
      first-page-column = "1:1";
    };
  };
}

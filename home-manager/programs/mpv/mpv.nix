{pkgs, ...}: {
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
}

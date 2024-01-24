{ pkgs, ... }: {
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
      ytdl-format = "bestvideo[height<=?1080][fps<=?60][vcodec!=?vp9]+bestaudio/best";
      cache = "yes";
      gpu-context = "wayland";
    };
  };
  programs.yt-dlp = {
      enable=true;
      settings = {
                 embed-thumbnail = true;
                 audio-quality = 0;
                 embed-metadata = true;
                 embed-subs = true;
                 sub-langs = "all";
                 embed-chapters = true;
                 downloader = "aria2c";
                 downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
                 format = "bestvideo[height<=?1080][fps<=?60][vcodec!=?vp9]+bestaudio/best";
      };

};
}

{pkgs, ...}: {
  # mpv --lavfi-complex="[vid1][vid2]hstack[vo];[aid1][aid2]amix[ao]" FOO.mkv --external-file=BAR.mkv
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
      vo = "gpu-next";
      profile = "gpu-hq";
      sub-auto = "fuzzy";
      sub-codepage = "gbk";
      osc = "no";
      osd-bar = "no";
      border = "no";
      ytdl-format = "bestvideo[height<=?1080][fps<=?60][vcodec!=?vp9]+bestaudio/best";
      cache = "yes";
      gpu-context = "wayland";
      input-ipc-server = "/tmp/mpvsocket";
      # forces showing subtitles while seeking through the video
      demuxer-mkv-subtitle-preroll = true;
      save-position-on-quit = true;
      force-seekable = true;
      # some settings fixing VOB/PGS subtitles (creating blur & changing yellow subs to gray)
      sub-gauss = "1.0";
      sub-gray = true;
      sub-use-margins = false;
      sub-font-size = 45;
      sub-scale-by-window = true;
      sub-scale-with-window = false;
      deband = true;
      deband-grain = 0;
      deband-range = 12;
      deband-threshold = 32;

      dither-depth = "auto";
      dither = "fruit";
      slang = "en,eng,english";
      alang = "jp,jpn,japanese,en,eng,english";
    };
  };
  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-thumbnail = true;
      audio-quality = 0;
      embed-metadata = true;
      embed-subs = true;
      sub-langs = "all";
      embed-chapters = true;
      downloader = "aria2c";
      downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
      format = "bestvideo[height<=?1080][fps<=?60][ext!=webm][vcodec!=?av1]+bestaudio/best";
    };
  };
}

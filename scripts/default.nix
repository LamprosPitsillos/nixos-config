{ pkgs
, lib
}: {
  screen_rec = lib.getExe (pkgs.writeShellApplication {
    name = "sh_screen_rec";
    runtimeInputs = with pkgs; [ slurp wl-screenrec yazi mpv ripdrag tofi libnotify ];
    text = ''
      SCREEN_REC_DIR="$HOME/vids/Screen_rec"

      start_screen_recording() {
          name="$1"
          screen_rec_name="$(date +'%Y-%m-%d_%H-%M-%S')_$name"
          path="$SCREEN_REC_DIR/$screen_rec_name.mp4"
          case "$2" in
              area) wl-screenrec -g "$(slurp)" -f "$path" ;;
              full) wl-screenrec -f "$path" ;;
          esac
      }

      if pkill -SIGINT wl-screenrec; then
          # shellcheck disable=SC2012
          screen_rec_name=$(ls -t "$SCREEN_REC_DIR" | head --lines=1)
          screen_rec="$SCREEN_REC_DIR/$screen_rec_name"
          cmd=$(notify-send "Screen Recording" "Screen Rec Done" \
                  -A "ripdrag  $screen_rec"=Drag \
                  -A "mpv  $screen_rec"=Open \
                  -A "yazi  $SCREEN_REC_DIR"=Goto)
          eval "$cmd"
      else
          name="$(echo | tofi --prompt-text='Name: ' --require-match=false --height=8% | tr ' ' '_')"
          if [ -z "$name" ];then
              notify-send "Screen Recording" "Screen Rec canceled, no name given."
              exit
          fi
          start_screen_recording "$name" "$1"
      fi
    '';
  });
  screen_shot = lib.getExe (pkgs.writeShellApplication {
    name = "sh_screen_shot";
    runtimeInputs = with pkgs;[ tofi grim swappy slurp libnotify ];
    text =
      ''
        SCREEN_SHOT_DIR=$HOME/pics/Screenshot
        name=$(echo | tofi  --prompt-text="Name: " --require-match=false --height=8% | tr " " "_")
        if [ -z "$name" ];then
            notify-send "Screen Shot" "Screen Shot canceled, no name given."
            exit
        fi
        case "$1" in
                area) grim  -g "$(slurp)" - | swappy  -f - -o "$SCREEN_SHOT_DIR/$(date +'%Y-%m-%d_%H-%M-%S')_$name".png ;;
                full) sleep 0.2 && grim  - | swappy -f - -o "$SCREEN_SHOT_DIR/$(date +'%Y-%m-%d_%H-%M-%S')_$name".png ;;
        esac
      '';

  });
  screen_to_text = lib.getExe (pkgs.writeShellApplication {
      name="screen2text";
      runtimeInputs = with pkgs; [ grim slurp tesseract wl-clipboard ];
      text= ''grim -g "$(slurp)" - | tesseract stdin stdout | wl-copy --primary '';
   });
  mpv_music_player = lib.getExe (pkgs.writeShellApplication {
    name = "sh_mpv_music_player"; /* sh */
    runtimeInputs = with pkgs; [ fd mpv libnotify fzf ];
    text = ''
      while true ;do
          song="$(fd . --base-directory="/home/inferno/music" --color=always --strip-cwd-prefix | fzf  --ansi --border --height=100% --preview="ffprobe -hide_banner ~/music/{} || exa ~/music/{}" )" #
          # shellcheck disable=SC2016
          mpv --input-ipc-server=/tmp/mpvsocket \
              --shuffle ~/music/"$song" \
              --msg-module \
              --term-title='󰎈 Playing: ''${filename} 󰎈'
          notify-send "MPV music" "Playlist has finished."
      done

    '';

  });
  mpv_controller = lib.getExe (pkgs.writeShellApplication {
    name = "sh_mpv_controller";
    runtimeInputs = with pkgs; [ socat libnotify ];
    text = ''
      case "$1" in
          next) echo 'playlist-next' | socat - /tmp/mpvsocket && notify-send MPV "Next song 󰙡" -i "mpv"
              ;;
          prev) echo 'playlist-prev' | socat - /tmp/mpvsocket && notify-send MPV "Prev song 󰙣" -i "mpv"
              ;;
          toggle) echo 'cycle pause' | socat - /tmp/mpvsocket && notify-send MPV "Toggle pause 󰏤" -i "mpv"
              ;;
          *) notify-send Error "\"$1\" is not a valid command"
              ;;
      esac
    '';
  }
  );
  fuzzy_browser = lib.getExe (pkgs.writeShellApplication {
    name = "fuzzy_browser";
    runtimeInputs = with pkgs; [ qutebrowser tofi ];
    text = ''
      quickmarks=$(cut -f1 -d\ < "$XDG_CONFIG_HOME/qutebrowser/quickmarks" )
      query=$(printf "%s\n" "$quickmarks" | tofi  --text-cursor=true --prompt-text "󰜏 " --require-match=false )
      [ -z "$query" ] || qutebrowser --target window ":open -t $query"
    '';
  }
  );


}

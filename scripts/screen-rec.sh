#!/usr/bin/env dash

SCREEN_REC_DIR="$HOME/vids/Screen_rec"

start_screen_recording() {
    name="$1"
    if [ -n "$name" ]; then
        screen_rec_name="$(date +'%Y-%m-%d_%H-%M-%S')_$name"
        path="$SCREEN_REC_DIR/$screen_rec_name.mp4"
        case "$2" in
            area) wl-screenrec -g "$(slurp)" -f "$path" ;;
            *) wl-screenrec -f "$path" ;;
        esac
    else
        notify-send "Screen Recording" "Screen Rec canceled, no name given."
    fi
}

if pkill -SIGINT wl-screenrec; then
    screen_rec_name=$(ls -t "$SCREEN_REC_DIR" | head --lines=1)
    screen_rec="$SCREEN_REC_DIR/$screen_rec_name"
    cmd=$(notify-send "Screen Recording" "Screen Rec Done" \
        -A "ripdrag $screen_rec"=Drag \
        -A "mpv $screen_rec"=Open \
        -A "yazi $SCREEN_REC_DIR"=Goto)
    eval "${cmd}"
else
    name="$(echo | tofi --prompt-text='Name: ' --require-match=false --height=8% | tr ' ' '_')"
    start_screen_recording "$name" "$1"
fi

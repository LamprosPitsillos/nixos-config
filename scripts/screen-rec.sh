#!/usr/bin/env dash
#
SCREEN_REC_DIR="$HOME/vids/Screen_rec"
if pkill -SIGINT wf-recorder  ;then
    # shellcheck disable=SC2012
    screen_rec_name="$( ls -t "$SCREEN_REC_DIR" | head --lines=1)"
    screen_rec="$SCREEN_REC_DIR/$screen_rec_name"
    cmd=$(notify-send "Screen Recording" "Screen Rec Done" \
    -A "ripdrag $screen_rec"=Drag \
    -A "mpv $screen_rec"=Open \
    -A "vifm $SCREEN_REC_DIR"=Goto)
    eval "${cmd}"

else
    name="$(echo | tofi --prompt-text='Name: ' --require-match=false --height=8% | tr ' ' '_')"
    if [ -n "$name" ]; then
        screen_rec_name="$(date +'%Y-%m-%d_%H-%M-%S')_$name"
        path="$SCREEN_REC_DIR/$screen_rec_name.mp4"
        case "$1" in
            area) wf-recorder -g "$(slurp)" -f "$path" -c h264_vaapi -d /dev/dri/renderD129
            ;;
            *) wf-recorder -f "$path" -c h264_vaapi -d /dev/dri/renderD129
            ;;
        esac
        
    else
        notify-send "Screen Recording" "Screen Rec Canceled"
    fi
fi
    

#!/bin/sh

# db=$HOME/.local/share/qutebrowser/history.sqlite
# url=$(sqlite3 "$db" "select url, title, atime from History" | tac | awk -F '|' '{print $1}' | rofi -dmenu -theme Input_icon -p "󰜏")
# [ -z "$url" ] && exit
# qutebrowser --target window "$url"

quickmarks=$(cut -f1 -d\ < "$XDG_CONFIG_HOME/qutebrowser/quickmarks" )
query=$(printf "%s\n" "${quickmarks}" | tofi  --text-cursor=true --prompt-text "󰜏 " --require-match=false )
[ -z "$query" ] || qutebrowser --target window ":open -t $query"

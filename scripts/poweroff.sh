#!/bin/sh

RET=$(printf "󰐥 Shutdown\n󰜉 Reboot\n󰌾 Lock\n󰅚 Cancel" | tofi --padding-left=10% --padding-right=10%)
case $RET in
	*Shutdown) notify-send "System" "The PC is <span color=\"red\"><b>shuting</b></span>\ down!" -i "system-shutdown" || systemctl poweroff ;;
	*Reboot) notify-send "System" "The PC is <span color=\"orange\"><b>rebooting</b></span>\!" -i "system-restart"   || systemctl reboot;;
	*Lock) notify-send "System" "The PC is <span color=\"orange\"><b>rebooting</b></span>\!" -i "system-lock-screen"     || gtklock ;;
	*) ;;
esac

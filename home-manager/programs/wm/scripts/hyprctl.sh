#!/usr/bin/env dash

# check_tty(){ }
error(){
    if [ -t 1 ] ; then
        printf 'Hyprland\nERROR: %s\n' "$1"
    else
        notify-send "Hyprland" "ERROR: $1"
    fi
    return 1
}
debug(){
        printf 'DEBUG: %s\n' "$1"
}
success(){
    if [ -t 1 ] ; then
        printf 'Hyprland\n SUCCESS: %s\n' "$1"
    else
        notify-send "Hyprland" "SUCCESS: $1"
    fi

}
get_opt(){
value_type="";
case "$2" in
    o|option)
        value_type=".option"
        ;;
    i|int)
        value_type=".int"
        ;;
    f|float)
        value_type=".float"
        ;;
    s|str)
        value_type=".str"
        ;;
    d|data)
        value_type=".data"
        ;;
    b|bool)
        value_type=".set"
        ;;
    *) error "'$2' is not a valid opt type."
        exit 1
        ;;
esac

value=$( hyprctl getoption "$1" -j | jq -r "$value_type" 2> /dev/null )

if [ "$value" = "no such option" ];then
    error "'$1' is not a valid opt name."
    exit 1
fi
printf '%s' "$value"
}

set_opt(){

error_value=$(hyprctl keyword "$1" "$2" )

if [ "$error_value" != "ok" ]; then
    error "$error_value"
    exit 1
fi

success "Value '$1' changed successfully to '$2' !"

}
toggle_opt(){
    opt_value=$(get_opt "$1" "int")
    value=true
    if [ "$opt_value" = 1 ];then
        value=false
    fi
    set_opt "$1" "$value" 

    # success "Value '$1' toggled successfully to '$value' !"

}

if [ "$1" = "toggle" ]; then
    shift
    toggle_opt "$1" "$2"
elif [ "$1" = "set" ];then
    shift
    set_opt "$1" "$2"
elif [ "$1" = "get" ];then
    shift
    get_opt "$1" "$2"
fi

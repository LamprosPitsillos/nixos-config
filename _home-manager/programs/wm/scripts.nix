{ pkgs
, lib
}: {
  #--------------------------------------------------------------------#
  #                  A naive hyprland option toggler                   #
  #--------------------------------------------------------------------#
  toggle = pkgs.writeScript "hypr_toggle" /* sh */
    ''
      #!${pkgs.dash}/bin/dash
      notify(){
          header="Hyprland:: $1"
          context="$2"
          notify-send "$header" "$context"
      }
      opt="$1"
      type=".$2"
      from="$3"
      to="$4"
      case "$type" in
          (.int|.str|.data|.set)
              ;;
          (.float)
              if [ ''${#from} -ne 8 ]; then
                  notify "Invalid length" ".float type length must be 8"
                  exit 1
              fi
              ;;
          (*)
              notify "Invalid type" "Type must be one of: (.int|.float|.str|.data|.set)"
              exit 1
              ;;
      esac

      current="$(hyprctl getoption "$opt" -j | ${lib.getExe pkgs.jq} "$type")"

      if [ "$current" = "$from" ]; then final="$to"; else final="$from"; fi

      ret="$( hyprctl keyword "$opt" "$final" )"

      if [ "$ret" = "ok" ];then
          notify "Toggled \"$opt\"" "Toggled from \"$current\" to \"$final\""
      else
          notify "ERROR:: Toggle" "\"$ret\" | $opt $type $from $to"
      fi
    '';
  #--------------------------------------------------------------------#
  #               Create and populate special workspaces               #
  #                     with a single application                      #
  #              if it's already active , switch to it                 #
  #--------------------------------------------------------------------#
  scratchpad = pkgs.writeScript "scratchpad" /* sh */
    ''
      #!${pkgs.dash}/bin/dash

      windows_in(){
          hyprctl clients -j | ${lib.getExe pkgs.jq} ".[] | select(.workspace.name == \"special:$1\" )"
      }

      toggle_scratchpad(){
          workspace_name="$1"
          cmd="$2"

          windows=$( windows_in "$workspace_name" )
          if [ -z "$windows" ];then
              hyprctl dispatch "exec [workspace special:$workspace_name] $cmd"
          else
              hyprctl dispatch togglespecialworkspace "$workspace_name"
          fi
      }

      if [ ! $# = 2 ];then
          notify-send "Given $# arguments , expected 2"
      else
          toggle_scratchpad "$1" "$2"
      fi
    '';
}

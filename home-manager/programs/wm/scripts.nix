{
pkgs,lib
}:{

      #--------------------------------------------------------------------#
      #                      A simple zoom "toggler"                       #
      #--------------------------------------------------------------------#
      zoom = pkgs.writeScript "hypr_zoom" /* sh */
      ''
      #!${pkgs.dash}/bin/dash

      if [ "$(hyprctl getoption misc:cursor_zoom_factor -j |${lib.getExe pkgs.jq} '.float')" = "1.00000" ]; then
          hyprctl keyword misc:cursor_zoom_factor 4
      else
          hyprctl keyword misc:cursor_zoom_factor 1
      fi
      '';

      #--------------------------------------------------------------------#
      #               Create and populate special workspaces               #
      #                     with a single application                      #
      #              if it's already active , switch to it                 #
      #--------------------------------------------------------------------#
      scratchpads = pkgs.writeScript "scratchpads" /* sh */
      ''
      #!${pkgs.dash}/bin/dash

      windows_in(){
          hyprctl clients -j | jq ".[] | select(.workspace.name == \"special:$1\" )"
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

      toggle_scratchpad "$1" "$2"
      '';
   }

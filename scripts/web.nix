{pkgs,lib,...}:{
yoink-site= pkgs.writeShellApplication {
    name= "yoink-site";
    runtimeInputs = with pkgs; [wget gawk];
    text= ''
        # Check if the URL parameter is provided
        if [ -z "$1" ]; then
          echo "Usage: $0 <URL> <PATH?>"
          exit 1
        fi

        # URL of the website to download
        URL="$1"

        # Directory to save the downloaded files
        SAVE_DIR="''${2:-.}"

        # Create the directory if it doesn't exist
        mkdir -p "$SAVE_DIR" || {
          echo "Error: Unable to create directory $SAVE_DIR"
          exit 1
        }

        # Use wget to download the website
        wget \
          --recursive \
          --no-clobber \
          --page-requisites \
          --convert-links \
          --level=5 \
          --html-extension \
          --domains "$(awk -F[/:] '{print $4}' <<< "$URL")" \
          --no-parent \
          -P "$SAVE_DIR" \
          "$URL"
   '';
    };

    }

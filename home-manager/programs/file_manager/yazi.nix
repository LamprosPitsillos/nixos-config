{ pkgs, lib, ... }: {

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    theme = {
      which = {
        mask = { bg = "#404145"; };
      };

    };
    keymap = let leader = "<Space>"; in {
      completion.keymap = [
        { on = [ "<C-q>" ]; run = "close"; desc = "Cancel completion"; }
        { on = [ "<Tab>" ]; run = "close --submit"; desc = "Submit the completion"; }
        { on = [ "<C-k>" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<C-j>" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "g" "?" ]; run = "help"; desc = "Open help"; }
      ];
      help.keymap = [
        { on = [ "<Esc>" ]; run = "escape"; desc = "Clear the filter, or hide the help"; }
        { on = [ "q" ]; run = "close"; desc = "Exit the process"; }
        { on = [ "<C-q>" ]; run = "close"; desc = "Hide the help"; }
        { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "j" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "K" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
        { on = [ "J" ]; run = "arrow 5"; desc = "Move cursor down 5 lines"; }
        { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "<S-Up>" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
        { on = [ "<S-Down>" ]; run = "arrow 5"; desc = "Move cursor down 5 lines"; }
        { on = [ "/" ]; run = "filter"; desc = "Apply a filter for the help items"; }
      ];
      input.keymap = [
        { on = [ "<C-q>" ]; run = "close"; desc = "Cancel input"; }
        { on = [ "<Enter>" ]; run = "close --submit"; desc = "Submit the input"; }
        { on = [ "<Esc>" ]; run = "escape"; desc = "Go back the normal mode, or cancel input"; }
        { on = [ "i" ]; run = "insert"; desc = "Enter insert mode"; }
        { on = [ "a" ]; run = "insert --append"; desc = "Enter append mode"; }
        { on = [ "I" ]; run = [ "move -999" "insert" ]; desc = "Move to the BOL, and enter insert mode"; }
        { on = [ "A" ]; run = [ "move 999" "insert --append" ]; desc = "Move to the EOL, and enter append mode"; }
        { on = [ "v" ]; run = "visual"; desc = "Enter visual mode"; }
        { on = [ "V" ]; run = [ "move -999" "visual" "move 999" ]; desc = "Enter visual mode and select all"; }
        { on = [ "h" ]; run = "move -1"; desc = "Move back a character"; }
        { on = [ "l" ]; run = "move 1"; desc = "Move forward a character"; }
        { on = [ "<Left>" ]; run = "move -1"; desc = "Move back a character"; }
        { on = [ "<Right>" ]; run = "move 1"; desc = "Move forward a character"; }
        { on = [ "<C-b>" ]; run = "move -1"; desc = "Move back a character"; }
        { on = [ "<C-f>" ]; run = "move 1"; desc = "Move forward a character"; }
        { on = [ "b" ]; run = "backward"; desc = "Move back to the start of the current or previous word"; }
        { on = [ "w" ]; run = "forward"; desc = "Move forward to the start of the next word"; }
        { on = [ "e" ]; run = "forward --end-of-word"; desc = "Move forward to the end of the current or next word"; }
        { on = [ "<A-b>" ]; run = "backward"; desc = "Move back to the start of the current or previous word"; }
        { on = [ "<A-f>" ]; run = "forward --end-of-word"; desc = "Move forward to the end of the current or next word"; }
        { on = [ "0" ]; run = "move -999"; desc = "Move to the BOL"; }
        { on = [ "$" ]; run = "move 999"; desc = "Move to the EOL"; }
        { on = [ "<C-a>" ]; run = "move -999"; desc = "Move to the BOL"; }
        { on = [ "<C-e>" ]; run = "move 999"; desc = "Move to the EOL"; }
        { on = [ "<Backspace>" ]; run = "backspace"; desc = "Delete the character before the cursor"; }
        { on = [ "<C-h>" ]; run = "backspace"; desc = "Delete the character before the cursor"; }
        { on = [ "<C-d>" ]; run = "backspace --under"; desc = "Delete the character under the cursor"; }
        { on = [ "<C-u>" ]; run = "kill bol"; desc = "Kill backwards to the BOL"; }
        { on = [ "<C-k>" ]; run = "kill eol"; desc = "Kill forwards to the EOL"; }
        { on = [ "<C-w>" ]; run = "kill backward"; desc = "Kill backwards to the start of the current word"; }
        { on = [ "<A-d>" ]; run = "kill forward"; desc = "Kill forwards to the end of the current word"; }
        { on = [ "d" ]; run = "delete --cut"; desc = "Cut the selected characters"; }
        { on = [ "D" ]; run = [ "delete --cut" "move 999" ]; desc = "Cut until the EOL"; }
        { on = [ "c" ]; run = "delete --cut --insert"; desc = "Cut the selected characters, and enter insert mode"; }
        { on = [ "C" ]; run = [ "delete --cut --insert" "move 999" ]; desc = "Cut until the EOL, and enter insert mode"; }
        { on = [ "x" ]; run = [ "delete --cut" "move 1 --in-operating" ]; desc = "Cut the current character"; }
        { on = [ "y" ]; run = "yank"; desc = "Copy the selected characters"; }
        { on = [ "p" ]; run = "paste"; desc = "Paste the copied characters after the cursor"; }
        { on = [ "P" ]; run = "paste --before"; desc = "Paste the copied characters before the cursor"; }
        { on = [ "u" ]; run = "undo"; desc = "Undo the last operation"; }
        { on = [ "<C-r>" ]; run = "redo"; desc = "Redo the last operation"; }
        { on = [ "g" "?" ]; run = "help"; desc = "Open help"; }
      ];
      manager.keymap = [
        { on = [ "<Esc>" ]; run = "escape"; desc = "Exit visual mode, clear selected, or cancel search"; }
        { on = [ leader "d" ]; run = ''shell 'ripdrag -x -n -i "''$@"' --confirm''; desc = "Drag n Drop Selection"; }
        { on = [ "q" ]; run = "quit"; desc = "Exit the process"; }
        { on = [ "Q" ]; run = "quit --no-cwd-file"; desc = "Exit the process without writing cwd-file"; }
        { on = [ "<C-q>" ]; run = "close"; desc = "Close the current tab, or quit if it is last tab"; }
        { on = [ "<C-z>" ]; run = "suspend"; desc = "Suspend the process"; }
        { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "j" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "K" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
        { on = [ "J" ]; run = "arrow 5"; desc = "Move cursor down 5 lines"; }
        { on = [ "<S-Up>" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
        { on = [ "<S-Down>" ]; run = "arrow 5"; desc = "Move cursor down 5 lines"; }
        { on = [ "<C-u>" ]; run = "arrow -50%"; desc = "Move cursor up half page"; }
        { on = [ "<C-d>" ]; run = "arrow 50%"; desc = "Move cursor down half page"; }
        { on = [ "<C-b>" ]; run = "arrow -100%"; desc = "Move cursor up one page"; }
        { on = [ "<C-f>" ]; run = "arrow 100%"; desc = "Move cursor down one page"; }
        { on = [ "<C-PageUp>" ]; run = "arrow -50%"; desc = "Move cursor up half page"; }
        { on = [ "<C-PageDown>" ]; run = "arrow 50%"; desc = "Move cursor down half page"; }
        { on = [ "<PageUp>" ]; run = "arrow -100%"; desc = "Move cursor up one page"; }
        { on = [ "<PageDown>" ]; run = "arrow 100%"; desc = "Move cursor down one page"; }
        { on = [ "h" ]; run = [ "leave" "escape --visual --select" ]; desc = "Go back to the parent directory"; }
        { on = [ "l" ]; run = [ "enter" "escape --visual --select" ]; desc = "Enter the child directory"; }
        { on = [ "H" ]; run = "back"; desc = "Go back to the previous directory"; }
        { on = [ "L" ]; run = "forward"; desc = "Go forward to the next directory"; }
        { on = [ "<A-k>" ]; run = "peek -5"; desc = "Peek up 5 units in the preview"; }
        { on = [ "<A-j>" ]; run = "peek 5"; desc = "Peek down 5 units in the preview"; }
        { on = [ "<A-PageUp>" ]; run = "peek -5"; desc = "Peek up 5 units in the preview"; }
        { on = [ "<A-PageDown>" ]; run = "peek 5"; desc = "Peek down 5 units in the preview"; }
        { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "<Left>" ]; run = "leave"; desc = "Go back to the parent directory"; }
        { on = [ "<Right>" ]; run = "enter"; desc = "Enter the child directory"; }
        { on = [ "g" "g" ]; run = "arrow -99999999"; desc = "Move cursor to the top"; }
        { on = [ "G" ]; run = "arrow 99999999"; desc = "Move cursor to the bottom"; }
        { on = [ "t" ]; run = [ "select --state=none" "arrow 1" ]; desc = "Toggle the current selection state"; }
        { on = [ "v" ]; run = "visual_mode"; desc = "Enter visual mode (selection mode)"; }
        { on = [ "V" ]; run = "visual_mode --unset"; desc = "Enter visual mode (unset mode)"; }
        { on = [ "<C-a>" ]; run = "select_all --state=true"; desc = "Select all files"; }
        { on = [ "<C-r>" ]; run = "select_all --state=none"; desc = "Inverse selection of all files"; }
        { on = [ "o" ]; run = "open"; desc = "Open the selected files"; }
        { on = [ "O" ]; run = "open --interactive"; desc = "Open the selected files interactively"; }
        { on = [ "<Enter>" ]; run = "open"; desc = "Open the selected files"; }
        { on = [ "<C-Enter>" ]; run = "open --interactive"; desc = "Open the selected files interactively"; }
        { on = [ "y" ]; run = [ "yank" "escape --visual --select" ]; desc = "Copy the selected files"; }
        { on = [ "x" ]; run = [ "yank --cut" "escape --visual --select" ]; desc = "Cut the selected files"; }
        { on = [ "p" ]; run = "paste"; desc = "Paste the files"; }
        { on = [ "P" ]; run = "paste --force"; desc = "Paste the files (overwrite if the destination exists)"; }
        { on = [ "-" ]; run = "link"; desc = "Symlink the absolute path of files"; }
        { on = [ "_" ]; run = "link --relative"; desc = "Symlink the relative path of files"; }
        { on = [ "d" ]; run = [ "remove" "escape --visual --select" ]; desc = "Move the files to the trash"; }
        { on = [ "D" ]; run = [ "remove --permanently" "escape --visual --select" ]; desc = "Permanently delete the files"; }
        { on = [ "a" ]; run = "create"; desc = "Create a file or directory (ends with / for directories)"; }
        { on = [ "r" ]; run = "rename"; desc = "Rename a file or directory"; }
        { on = [ ";" ]; run = "shell"; desc = "Run a shell command"; }
        { on = [ ":" ]; run = "shell --block"; desc = "Run a shell command (block the UI until the command finishes)"; }
        { on = [ "." ]; run = "hidden toggle"; desc = "Toggle the visibility of hidden files"; }
        { on = [ "f" ]; run = "search fd"; desc = "Search files by name using fd"; }
        { on = [ "F" ]; run = "search rg"; desc = "Search files by content using ripgrep"; }
        { on = [ "<C-s>" ]; run = "search none"; desc = "Cancel the ongoing search"; }
        { on = [ "z" ]; run = "jump zoxide"; desc = "Jump to a directory using zoxide"; }
        { on = [ "Z" ]; run = "jump fzf"; desc = "Jump to a directory, or reveal a file using fzf"; }
        { on = [ "m" "s" ]; run = "linemode size"; desc = "Set linemode to size"; }
        { on = [ "m" "p" ]; run = "linemode permissions"; desc = "Set linemode to permissions"; }
        { on = [ "m" "m" ]; run = "linemode mtime"; desc = "Set linemode to mtime"; }
        { on = [ "m" "n" ]; run = "linemode none"; desc = "Set linemode to none"; }
        { on = [ "c" "c" ]; run = "copy path"; desc = "Copy the absolute path"; }
        { on = [ "c" "d" ]; run = "copy dirname"; desc = "Copy the path of the parent directory"; }
        { on = [ "c" "f" ]; run = "copy filename"; desc = "Copy the name of the file"; }
        { on = [ "c" "n" ]; run = "copy name_without_ext"; desc = "Copy the name of the file without the extension"; }
        { on = [ "/" ]; run = "find --smart"; }
        { on = [ "?" ]; run = "find --previous --smart"; }
        { on = [ "n" ]; run = "find_arrow"; }
        { on = [ "N" ]; run = "find_arrow --previous"; }

        { on = [ "s" "m" ]; run = "sort modified --dir_first"; desc               = "[s]ort by [m]odified time"; }
        { on = [ "s" "M" ]; run = "sort modified --reverse --dir_first"; desc     = "[s]ort by [M]odified time (reverse)"; }
        { on = [ "s" "c" ]; run = "sort created --dir_first"; desc                = "[s]ort by [c]reated time"; }
        { on = [ "s" "C" ]; run = "sort created --reverse --dir_first"; desc      = "[s]ort by [C]reated time (reverse)"; }
        { on = [ "s" "e" ]; run = "sort extension --dir_first"; desc              = "[s]ort by [e]xtension"; }
        { on = [ "s" "E" ]; run = "sort extension --reverse --dir_first"; desc    = "[s]ort by [E]xtension (reverse)"; }
        { on = [ "s" "a" ]; run = "sort alphabetical --dir_first"; desc           = "[s]ort [a]lphabetically"; }
        { on = [ "s" "A" ]; run = "sort alphabetical --reverse --dir_first"; desc = "[s]ort [A]lphabetically (reverse)"; }
        { on = [ "s" "n" ]; run = "sort natural --dir_first"; desc                = "[s]ort [n]aturally"; }
        { on = [ "s" "N" ]; run = "sort natural --reverse --dir_first"; desc      = "[s]ort [N]aturally (reverse)"; }
        { on = [ "s" "s" ]; run = "sort size --dir_first"; desc                   = "[s]ort by [s]ize"; }
        { on = [ "s" "S" ]; run = "sort size --reverse --dir_first"; desc         = "[s]ort by [S]ize (reverse)"; }

        { on = [ "<C-t>" ]; run = "tab_create --current"; desc                    = "Create a new tab using the current path"; }
        { on = [ "1" ]; run = "tab_switch 0"; desc = "Switch to the first tab"; }
        { on = [ "2" ]; run = "tab_switch 1"; desc = "Switch to the second tab"; }
        { on = [ "3" ]; run = "tab_switch 2"; desc = "Switch to the third tab"; }
        { on = [ "4" ]; run = "tab_switch 3"; desc = "Switch to the fourth tab"; }
        { on = [ "5" ]; run = "tab_switch 4"; desc = "Switch to the fifth tab"; }
        { on = [ "6" ]; run = "tab_switch 5"; desc = "Switch to the sixth tab"; }
        { on = [ "7" ]; run = "tab_switch 6"; desc = "Switch to the seventh tab"; }
        { on = [ "8" ]; run = "tab_switch 7"; desc = "Switch to the eighth tab"; }
        { on = [ "9" ]; run = "tab_switch 8"; desc = "Switch to the ninth tab"; }
        { on = [ "[" ]; run = "tab_switch -1 --relative"; desc = "Switch to the previous tab"; }
        { on = [ "]" ]; run = "tab_switch 1 --relative"; desc = "Switch to the next tab"; }
        { on = [ "{" ]; run = "tab_swap -1"; desc = "Swap the current tab with the previous tab"; }
        { on = [ "}" ]; run = "tab_swap 1"; desc = "Swap the current tab with the next tab"; }
        { on = [ "w" ]; run = "tasks_show"; desc = "Show the tasks manager"; }

        { on = [ "g" "h" ]; run = "cd ~"; desc = "goto ~"; }
        { on = [ "g" "c" ]; run = "cd ~/.config"; desc = "goto .config"; }
        { on = [ "g" "d" ]; run = "cd ~/downs"; desc = "goto downs"; }
        { on = [ "g" "t" ]; run = "cd /tmp"; desc = "goto /tmp"; }
        { on = [ "g" "<Space>" ]; run = "cd --interactive"; desc = "goto where?"; }

        { on = [ "g" "?" ]; run = "help"; desc = "Open help"; }
      ];
      select.keymap = [
        { on = [ "<C-q>" ]; run = "close"; desc = "Cancel selection"; }
        { on = [ "<Esc>" ]; run = "close"; desc = "Cancel selection"; }
        { on = [ "<Enter>" ]; run = "close --submit"; desc = "Submit the selection"; }
        { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "j" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "K" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
        { on = [ "J" ]; run = "arrow 5"; desc = "Move cursor down 5 lines"; }
        { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "<S-Up>" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
        { on = [ "<S-Down>" ]; run = "arrow 5"; desc = "Move cursor down 5 lines"; }
        { on = [ "g" "?" ]; run = "help"; desc = "Open help"; }
      ];
      tasks.keymap = [
        { on = [ "<Esc>" ]; run = "close"; desc = "Hide the task manager"; }
        { on = [ "<C-q>" ]; run = "close"; desc = "Hide the task manager"; }
        { on = [ "w" ]; run = "close"; desc = "Hide the task manager"; }
        { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "j" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "<Enter>" ]; run = "inspect"; desc = "Inspect the task"; }
        { on = [ "x" ]; run = "cancel"; desc = "Cancel the task"; }
        { on = [ "~" ]; run = "help"; desc = "Open help"; }
      ];
    };
    settings = {
      manager =
        {
          layout = [ 0 2 3 ];
          sort_by = "modified";
          sort_reverse = true;
          sort_dir_first = true;
          show_hidden = false;
          show_symlink = true;
        };

      preview =
        {
          tab_size = 5;
          max_width = 600;
          max_height = 900;
          cache_dir = "";
        };


      tasks =
        {
          micro_workers = 5;
          macro_workers = 10;
          bizarre_retry = 5;
        };

      log.enabled = false;

    };

  };
}

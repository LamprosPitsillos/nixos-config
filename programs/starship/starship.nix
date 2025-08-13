{ lib, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [ "$all" ];
      right_format = "";
      scan_timeout = 30;
      command_timeout = 500;
      # character = {
      #   success_symbol = "➜";
      #   error_symbol = "➜";
      # };

      continuation_prompt = "[∙](bright-black) ";

      username = {
        format = "[$user]($style) in ";
        style_root = "red bold";
        style_user = "yellow bold";
        show_always = false;
        disabled = false;
      };

      battery = {
        full_symbol = "󰁹 ";
        charging_symbol = "󰂄 ";
        discharging_symbol = "󰂃 ";
        unknown_symbol = "󰁽 ";
        empty_symbol = "󰂎 ";
        disabled = false;
        format = "[$symbol$percentage]($style) ";
      };

      battery.display = {
        threshold = 10;
        style = "red bold";
      };

      # c={
      # format = "via [$symbol($version(-$name) )]($style)";
      # version_format = "v\${raw}";
      # style = "149 bold";
      # symbol = "C ";
      # disabled = false;
      # detect_extensions = [ "c" "h" ];
      # detect_files = [];
      # detect_folders = [];
      # commands = [
      #     [ "cc" "--version" ]
      #     [ "gcc" "--version" ]
      #     [ "clang" "--version" ]
      # ];
      # };

      character = {
        format = "$symbol ";
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold green)";
        vimcmd_visual_symbol = "[❮](bold yellow)";
        vimcmd_replace_symbol = "[❮](bold purple)";
        vimcmd_replace_one_symbol = "[❮](bold purple)";
        disabled = false;
      };

      cmake = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "△ ";
        style = "bold blue";
        disabled = false;
        detect_extensions = [ ];
        detect_files = [ "CMakeLists.txt" "CMakeCache.txt" ];
      };

      cmd_duration = {
        min_time = 2000;
        format = "took [$duration]($style) ";
        style = "yellow bold";
        show_milliseconds = false;
        disabled = false;
        show_notifications = false;
        min_time_to_notify = 45000;
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        fish_style_pwd_dir_length = 0;
        use_logical_path = true;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        style = "cyan bold";
        disabled = false;
        read_only = "🔒";
        read_only_style = "red";
        truncation_symbol = "";
        home_symbol = "~";
        use_os_path_sep = true;
      };

      docker_context = {
        symbol = "🐳 ";
        style = "blue bold";
        format = "via [$symbol$context]($style) ";
        only_with_files = true;
        disabled = false;
        detect_extensions = [ ];
        detect_files = [
          "docker-compose.yml"
          "docker-compose.yaml"
          "Dockerfile"
        ];
      };

      fill = {
        style = "bold black";
        symbol = ".";
        disabled = false;
      };

      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
        symbol = " ";
        style = "bold purple";
        truncation_length = 9223372036854775807;
        truncation_symbol = "…";
        only_attached = false;
        always_show_remote = false;
        ignore_branches = [ ];
        disabled = false;
      };

      git_commit = {
        commit_hash_length = 7;
        format = "[\($hash$tag\)]($style) ";
        style = "green bold";
        only_detached = true;
        disabled = false;
        tag_symbol = " 🏷  ";
        tag_disabled = true;
        tag_max_candidates = 0;
      };

      git_metrics = {
        added_style = "bold green";
        deleted_style = "bold red";
        only_nonzero_diffs = true;
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
        disabled = true;
        ignore_submodules = false;
      };

      git_state = {
        rebase = "REBASING";
        merge = "MERGING";
        revert = "REVERTING";
        cherry_pick = "CHERRY-PICKING";
        bisect = "BISECTING";
        am = "AM";
        am_or_rebase = "AM/REBASE";
        style = "bold yellow";
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        disabled = false;
      };

      git_status = {
        format = "([\[$all_status$ahead_behind\]]($style) )";
        style = "red bold";
        stashed = "\$";
        ahead = "⇡";
        behind = "⇣";
        up_to_date = "";
        diverged = "⇕";
        conflicted = "=";
        deleted = "✘";
        renamed = "»";
        modified = "!";
        staged = "+";
        untracked = "?";
        typechanged = "";
        ignore_submodules = false;
        disabled = false;
      };

      hg_branch = {
        symbol = " ";
        style = "bold purple";
        format = "on [$symbol$branch(:$topic)]($style) ";
        truncation_length = 9223372036854775807;
        truncation_symbol = "…";
        disabled = true;
      };
      hostname = {
        ssh_only = true;
        ssh_symbol = "🌐 ";
        trim_at = ".";
        format = "[$ssh_symbol$hostname]($style) in ";
        style = "green dimmed bold";
        disabled = false;
      };

      jobs = {
        threshold = 1;
        symbol_threshold = 1;
        number_threshold = 2;
        format = "[$symbol$number]($style) ";
        symbol = "✦";
        style = "bold blue";
        disabled = false;
      };

      line_break = {
        disabled = false;
      };

      lua = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "🌙 ";
        style = "bold blue";
        lua_binary = "lua";
        disabled = false;
        detect_extensions = [ "lua" ];
        detect_files = [ ".lua-version" ];
        detect_folders = [ "lua" ];
      };

      memory_usage = {
        threshold = 75;
        format = "via $symbol[$ram( | $swap)]($style) ";
        style = "white bold dimmed";
        symbol = "🐏 ";
        disabled = true;
      };

      meson = {
        truncation_length = 4294967295;
        truncation_symbol = "…";
        format = "via [$symbol$project]($style) ";
        symbol = "⬢ ";
        style = "blue bold";
        disabled = false;
      };

      nix_shell = {
        format = "via [$symbol$state( \($name\))]($style) ";
        symbol = " ";
        style = "bold blue";
        impure_msg = "impure";
        pure_msg = "pure";
        unknown_msg = "";
        disabled = false;
        heuristic = false;
      };

      nodejs = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold green";
        disabled = false;
        not_capable_style = "bold red";
        detect_extensions = [ "js" "mjs" "cjs" "ts" "mts" "cts" ];
        detect_files = [ "package.json" ".node-version" ".nvmrc" ];
        detect_folders = [ "node_modules" ];
      };

      os = {
        format = "[$symbol]($style)";
        style = "bold white";
        disabled = true;
      };

      os.symbols = {
        NixOS = " ";
      };

      package = {
        format = "is [$symbol$version]($style) ";
        symbol = "📦 ";
        style = "208 bold";
        display_private = false;
        disabled = false;
        version_format = "v\${raw}";
      };

      python = {
        pyenv_version_name = false;
        pyenv_prefix = "pyenv ";
        python_binary = [ "python" "python3" "python2" ];
        format = "via [\${symbol}\${pyenv_prefix}(\${version} )(\($virtualenv\) )]($style)";
        version_format = "v\${raw}";
        style = "yellow bold";
        symbol = "🐍 ";
        disabled = false;
        detect_extensions = [ "py" ];
        detect_files = [ "requirements.txt" ".python-version" "pyproject.toml" "Pipfile" "tox.ini" "setup.py" "__init__.py" ];
        detect_folders = [ ];
      };

      rust = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "🦀 ";
        style = "bold red";
        disabled = false;
        detect_extensions = [ "rs" ];
        detect_files = [ "Cargo.toml" ];
        detect_folders = [ ];
      };

      sudo = {
        format = "[as $symbol]($style)";
        symbol = "🧙 ";
        style = "bold blue";
        allow_windows = false;
        disabled = true;
      };

      shell = {
        format = "[$indicator]($style) ";
        bash_indicator = "bsh";
        fish_indicator = "fsh";
        zsh_indicator = "zsh";
        powershell_indicator = "psh";
        ion_indicator = "ion";
        elvish_indicator = "esh";
        tcsh_indicator = "tsh";
        nu_indicator = "nu";
        xonsh_indicator = "xsh";
        cmd_indicator = "cmd";
        unknown_indicator = "";
        style = "white bold";
        disabled = true;
      };

      status = {
        format = "[$symbol$status]($style) ";
        symbol = "❌";
        success_symbol = "";
        not_executable_symbol = "🚫";
        not_found_symbol = "🔍";
        sigint_symbol = "🧱";
        signal_symbol = "⚡";
        style = "bold red";
        map_symbol = false;
        recognize_signal_code = true;
        pipestatus = false;
        pipestatus_separator = "|";
        pipestatus_format = "\[$pipestatus\] => [$symbol$common_meaning$signal_name$maybe_int]($style)";
        disabled = true;
      };

      time = {
        format = "at [$time]($style) ";
        style = "bold yellow";
        use_12hr = false;
        disabled = true;
        utc_time_offset = "local";
        time_range = "-";
      };
    };
  };
}

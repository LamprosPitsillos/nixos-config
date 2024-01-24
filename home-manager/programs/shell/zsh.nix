{ pkgs
, config
, lib
, ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    # syntaxHighlighting = {
    #   enable = true;
    #   package = pkgs.zsh-fast-syntax-highlighting;
    # };
    enableCompletion = true;
    # enableAutosuggestions = true;
    autocd = true;

    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "cf318e06a9b7c9f2219d78f41b46fa6e06011fd9";
          sha256 = "1bmrb724vphw7y2gwn63rfssz3i8lp75ndjvlk5ns1g35ijzsma5";
        };
      }
    ];
    history = {
      ignoreDups = true;
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      # share = true;
      size = 9999999;
    };
    defaultKeymap = "emacs";
    shellGlobalAliases = {
      CP = " ${pkgs.wl-clipboard}/bin/wl-copy ";
      CPp = " ${pkgs.wl-clipboard}/bin/wl-copy --primary ";
      PT = " ${pkgs.wl-clipboard}/bin/wl-paste ";
      PTp = " ${pkgs.wl-clipboard}/bin/wl-paste --primary ";
    };
    completionInit = ''
      autoload -U compinit
       zstyle ':completion:*' menu select
       zmodload zsh/complist
       fpath=( $ZDOTDIR/completions $fpath )
       compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
       # _comp_options+=(globdots)
    '';
    initExtra =
      /* sh */ ''
            # https://github.com/NotAShelf/nyx/blob/6db9e9ff81376831beaf5324c6e6f60739c1b907/homes/notashelf/terminal/shell/zsh.nix#L204
            stty stop undef

            zmodload zsh/zprof
            zmodload zsh/zle
            zmodload zsh/zpty
            # zmodload zsh/complist

            autoload -Uz colors && colors

            # Group matches and describe.
            zstyle ':completion:*' sort true
            zstyle ':completion:complete:*:options' sort true
            zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
            zstyle ':completion:*' special-dirs false
            zstyle ':completion:*' rehash true

            zstyle ':completion:*' menu yes select # search
            zstyle ':completion:*' verbose yes
            zstyle ':completion:*:matches' group 'yes'
            zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
            zstyle ':completion:*:messages' format '%d'
            zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

      LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:';
      export LS_COLORS

            zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

                # Fuzzy match mistyped completions.
                  zstyle ':completion:*' completer _complete _match _approximate
                  zstyle ':completion:*:match:*' original only
                  zstyle ':completion:*:approximate:*' max-errors 1 numeric

              # Don't complete unavailable commands.
                  zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

               # Autosuggest
                  ZSH_AUTOSUGGEST_USE_ASYNC="true"

            autoload -U up-line-or-beginning-search
            autoload -U down-line-or-beginning-search
            zle -N up-line-or-beginning-search
            zle -N down-line-or-beginning-search

            bindkey '^[k' history-substring-search-up
            bindkey '^[j' history-substring-search-down
            bindkey '^k' up-line-or-beginning-search
            bindkey '^j' down-line-or-beginning-search
            bindkey -M menuselect '^j' vi-down-line-or-history
            bindkey -M menuselect '^k' vi-up-line-or-history
            bindkey -M menuselect '^h' vi-backward-char
            bindkey -M menuselect '^l' vi-forward-char

            setopt APPEND_HISTORY EXTENDED_HISTORY HIST_FCNTL_LOCK HIST_REDUCE_BLANKS INC_APPEND_HISTORY SHARE_HISTORY HIST_VERIFY

            setopt AUTO_LIST AUTO_LIST AUTO_MENU \
            AUTO_PARAM_SLASH AUTO_PUSHD  \
            ALWAYS_TO_END COMPLETE_IN_WORD CORRECT \
            INTERACTIVE_COMMENTS MENU_COMPLETE NO_NOMATCH PUSHD_IGNORE_DUPS \
            PUSHD_TO_HOME PUSHD_SILENT
            unsetopt CORRECT_ALL HIST_BEEP MENU_COMPLETE

      function uzip() { unzip "$1" -d "$1%.*" }
      function mkcd () { mkdir -p $1 && cd ./$1 }
      function cwd () { echo -ne "\"$(pwd)\"" | wl-copy }

    '';
  };
}

{pkgs,lib,...} : {

    programs.yazi = {
        enable= true;
        enableZshIntegration =true;
        settings = {
manager = 
{ 
layout         = [ 1 4 3 ];
sort_by        = "modified";
sort_reverse   = true;
sort_dir_first = true;
show_hidden    = false;
show_symlink   = true ;
};

preview =
{ tab_size   = 2;
max_width  = 600;
max_height = 900;
cache_dir  = ""; };

opener =
{ folder = [
	{ exec = ''xdg-open "$@"''; display_name = "Reveal in Finder"; }
	{ exec = ''$EDITOR "$@"'' ;}
];
archive = [
	{ exec = ''unar "$1"''; display_name = "Extract here" ; }
];
text = [
	{ exec = ''$EDITOR "$@"''; block = true ;}
];
image = [
	{ exec = ''xdg-open "$@"''; display_name = "Open" ;}
	{ exec = ''exiftool "$1"; echo "Press enter to exit"; read''; block = true; display_name = "Show EXIF" ;}
];
video = [
	{ exec = ''mpv "$@"''; }
	{ exec = ''mediainfo "$1"; echo "Press enter to exit"; read''; block = true; display_name = "Show media info" ;}
];
audio = [
	{ exec = ''mpv "$@"''; }
	{ exec = ''mediainfo "$1"; echo "Press enter to exit"; read''; block = true; display_name = "Show media info" ;}
];
fallback = [
	{ exec = ''xdg-open "$@"''; display_name = "Open" ;}
];
};

open=
{ rules = [
	{ name = "*/"; use = "folder" ;}

	{ mime = "text/*"; use = "text" ;}
	{ mime = "image/*"; use = "image" ;}
	{ mime = "video/*"; use = "video" ;}
	{ mime = "audio/*"; use = "audio" ;}
	{ mime = "inode/x-empty"; use = "text" ;}

	{ mime = "application/json"; use = "text" ;}
	{ mime = "*/javascript"; use = "text" ;}

	{ mime = "application/zip"; use = "archive" ;}
	{ mime = "application/gzip"; use = "archive" ;}
	{ mime = "application/x-bzip"; use = "archive" ;}
	{ mime = "application/x-bzip2"; use = "archive" ;}
	{ mime = "application/x-tar"; use = "archive" ;}
	{ mime = "application/x-7z-compressed"; use = "archive" ;}
	{ mime = "application/x-rar"; use = "archive" ;}

	{ mime = "*"; use = "fallback" ;}
]; };

tasks=
{ micro_workers = 5;
macro_workers = 10;
bizarre_retry = 5 ;} ;

log.enabled = false;

    };

};
}

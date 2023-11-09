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


tasks=
{ micro_workers = 5;
macro_workers = 10;
bizarre_retry = 5 ;} ;

log.enabled = false;

    };

};
}

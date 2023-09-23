; Explicit annotations in comments:
;   /* lang */ ''script''
; or:
;   # lang
;   ''script''
((comment) @injection.language
  .
  (_ (string_fragment) @injection.content)
  (#gsub! @injection.language "[/*#%s]" "")
) @injection.combined

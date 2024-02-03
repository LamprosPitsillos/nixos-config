;; extends

;https://github.com/mushfiq814/dotfiles/tree/master/neovim/.config/nvim/after/queries

; offset and table chars courtesy of `megalithic`:
; https://github.com/megalithic/dotfiles/blob/39aa5fcefaa4d68cce66b6de425311e47c2d54fb/config/nvim/after/queries/markdown/highlights.scm#L45-L64

; list markers/bullet points
(
  ([
    (list_marker_star)
    (list_marker_plus)
    (list_marker_minus)
  ]) @punctuation.special
  (#offset! @punctuation.special 0 0 0 -1)
  (#set! conceal "•")
)

; checkboxes
((task_list_marker_unchecked) @text.todo.unchecked (#set! conceal ""))
((task_list_marker_checked) @text.todo.checked (#set! conceal ""))

; box drawing characters for tables
(pipe_table_header ("|") @punctuation.special @conceal (#set! conceal "│"))
(pipe_table_delimiter_row ("|") @punctuation.special @conceal (#set! conceal "│"))
(pipe_table_delimiter_cell ("-") @punctuation.special @conceal (#set! conceal "─"))
(pipe_table_row ("|") @punctuation.special @conceal (#set! conceal "│"))

; block quotes
((block_quote_marker) @markdown_quote_marker (#set! conceal "▍"))
((block_quote
  (paragraph (inline
    (block_continuation) @markdown_quote_marker (#set! conceal "▍")
  ))
))

; (fenced_code_block
;   (info_string) @devicon
;   (#as_devicon! @devicon))

(
  fenced_code_block (fenced_code_block_delimiter) @markup.raw.delimiter
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "javascript")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "typescript")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "json")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "bash")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "sh")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "lua")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "diff")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "vim")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "yaml")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "java")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "html")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "css")
  (#set! conceal "")
)
(
  [(info_string (language))] @label
  (#eq? @label "sql")
  (#set! conceal "")
)
; (
;   [(info_string (language))] @markdown_code_block_lang_sql
;   (#eq? @markdown_code_block_lang_sql "sql")
;   (#set! conceal "")
; )

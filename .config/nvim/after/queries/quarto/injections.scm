(fenced_code_block
  (info_string (language) @lang
    (#lua-match? @lang "^(=html|html)$"))
  (code_block) @injection.content
  (#set! injection.combined)
  (#set! injection.language @lang)

)

;; Eta template injections for embedded languages
;; Inject JavaScript highlighting into Eta code blocks

((code) @injection.content
  (#set! injection.language "javascript")
  (#set! injection.include-children))

;; Inject HTML into text nodes
((text) @injection.content
  (#set! injection.language "html")
  (#set! injection.include-children))


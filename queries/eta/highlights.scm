;; Eta template highlighting queries
;; These queries enable Treesitter-based syntax highlighting

;; Eta delimiters
[
  "<%"
  "%>"
  "<%="
  "<%~"
  "<%_"
] @tag.delimiter

;; Comments
(comment) @comment

;; JavaScript code blocks
(code) @embedded

;; HTML content
(text) @text


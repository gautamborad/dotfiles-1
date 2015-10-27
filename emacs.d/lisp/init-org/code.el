(setq org-confirm-babel-evaluate nil)

(require 'ob-sh)
; do I want 'ob-shell ?

(require 'ob-sql)

(require 'ob-haskell)

(require 'ob-scheme)

;; fontify our code blocks
(setq org-src-fontify-natively t)

;; edit src in the current window
(setq org-src-window-setup 'current-window)

;; don't indent src block code
(setq org-edit-src-content-indentation 0)

;; structure shortcuts
(add-to-list 'org-structure-template-alist
             '("hs" "#+begin_src haskell\n?\n#+end_src" "<src lang=\"haskell\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("hsnt" "#+begin_src haskell :tangle no\n?\n#+end_src" "<src lang=\"haskell\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("rs" "#+begin_src rust\n?\n#+end_src" "<src lang=\"rust\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("sh" "#+begin_src sh\n?\n#+end_src" "<src lang=\"sh\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("theorem" "#+begin_theorem\n?\n#+end_theorem" "<theorem>\n?\n</theorem>"))
(add-to-list 'org-structure-template-alist
             '("def" "#+begin_definition\n?\n#+end_definition" "<definition>\n?\n</definition>"))

(provide 'init-org/code)

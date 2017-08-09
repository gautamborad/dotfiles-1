(mjhoy/require-package 'psc-ide)
(mjhoy/require-package 'purescript-mode)

(defun mjhoy/purescript-mode-setup ()
  "Run to set up purescript mode."
  (psc-ide-mode)
  (flycheck-mode)
  (turn-on-purescript-indentation)
  (turn-on-purescript-decl-scan)
  )

(add-hook 'purescript-mode-hook 'mjhoy/purescript-mode-setup)

(setq psc-ide-use-npm-bin t)
(setq psc-ide-use-purs t)

(provide 'init-purescript)

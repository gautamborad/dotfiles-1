(mjhoy/require-package 'rainbow-mode)

(setq scss-compile-at-save nil)
(setq css-indent-offset 2)

(defun mjhoy/init-css-mode ()
  (rainbow-mode 1))

(add-hook 'css-mode-hook 'mjhoy/init-css-mode)

(provide 'init-css)

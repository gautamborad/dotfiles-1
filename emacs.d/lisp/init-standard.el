(setq backup-directory-alist
      (list (cons "."
                  (expand-file-name "backups"
                                    user-emacs-directory))))

(setq inhibit-splash-screen t)

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)
(setq require-final-newline t)
(setq tags-case-fold-search nil)

;; begone, crazy command
(global-unset-key (kbd "C-x C-u"))
(put 'upcase-region 'disabled nil)

;; find-file-at-point (replaces 'set-fill-column)
(global-set-key (kbd "C-x f") 'find-file-at-point)

;; enable narrowing
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

(provide 'init-standard)
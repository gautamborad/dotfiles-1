(mjhoy/require-package 'helm)

(require 'init-projectile)
(mjhoy/require-package 'helm-projectile)

;; I want to use helm for as much as possible, but one issue is that
;; it crashes on OSX for large matching lists, see:
;; https://github.com/bbatsov/projectile/issues/600
;;
;; Until then I'll keep ido around as well.

(require 'helm)

(require 'init-mu4e)

(if mjhoy/mu4e-exists-p
    (progn
      ;; note: requires gnu-sed on osx
      ;; $ brew install gnu-sed --with-default-names
      ;; more at https://github.com/emacs-helm/helm-mu
      (add-to-list 'load-path "~/.emacs.d/site-lisp/helm-mu")
      (autoload 'helm-mu "helm-mu" "" t)
      (autoload 'helm-mu-contacts "helm-mu" "" t)))

(global-set-key (kbd "C-c h k") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h i") 'helm-imenu)
(global-set-key (kbd "C-c h j") 'helm-etags-select)
(global-set-key (kbd "C-c h f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-c h o") 'helm-org-in-buffer-headings)
(global-set-key (kbd "C-c h e") 'helm-mu)

;; old buffer switching
(global-set-key (kbd "C-c h b") 'switch-to-buffer)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; helm projectile integration

(require 'helm-projectile)
(global-set-key (kbd "C-c h p") 'helm-projectile)

;(helm-projectile-on)

(provide 'init-helm)

(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ))

;; (setq debug-on-error t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t) ;; Install from repo if not yet available


(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general) ;; Require "layers"
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
;; else
  (require 'setup-helm)
  (require 'setup-helm-gtags)
  )
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-lisp)

(require 'spacemacs-dark-theme)

(use-package multi-term)


;; function-args
;; (require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (smartparens multi-term spacemacs-theme rebox rebox2 origami helm-company iedit anzu comment-dwim-2 ws-butler dtrt-indent clean-aindent-mode yasnippet undo-tree volatile-highlights helm-gtags helm-projectile helm-swoop helm zygospore projectile company use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

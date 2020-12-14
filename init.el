;;; emacs-config --- someonewithpc's Emacs config
;;; Commentary:
;;; A reduced but complete (for my uses) config,
;;; based on spacemacs

;;; Code:

(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path "~/.emacs.d/extern")

;; (setq debug-on-error t)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t) ;; Install from repo if not yet available

(set-register ?e '(file . "~/.emacs.d/init.el"))

;; Require "layers"
(require 'setup-general)
(require 'setup-helm)
;; (require 'setup-helm-gtags)
(require 'setup-editing)
(require 'setup-c)
(require 'setup-php)
;; (require 'setup-lisp)
;; (require 'setup-prolog)
(require 'setup-terminal) ;; Setup for using emacs in a terninal as well as a terminal in emacs
(require 'setup-programming)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(tango-dark))
 '(custom-safe-themes
   '("c7901691c1dd0d501f6ba5a296490d8b85f550aa0ece175b37008ea453b0a0bd" default))
 '(ggtags-enable-navigation-keys nil)
 '(ggtags-extra-args '("--skip-unreadable"))
 '(ggtags-sort-by-nearness t)
 '(ggtags-use-idutils t)
 '(package-selected-packages
   '(cmake-mode pdf-tools duplicate-thing zygospore xclip ws-butler web-mode volatile-highlights use-package undo-tree twig-mode tramp-auto-auth sql-indent smartparens smart-tabs-mode rebox2 pandoc-mode pandoc multiple-cursors material-theme markdown-mode+ iedit highlight-indent-guides helm-tramp helm-swoop helm-projectile helm-gtags helm-company haskell-mode gmpl-mode ggtags folding fold-dwim flycheck ewal-spacemacs-themes ewal-doom-themes elpy dumb-jump dtrt-indent drag-stuff dockerfile-mode docker-compose-mode company-php company-irony-c-headers company-irony company-c-headers comment-dwim-2 clean-aindent-mode auctex anzu ac-php)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)

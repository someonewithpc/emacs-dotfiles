;;; emacs-config --- someonewithpc's Emacs config
;;; Commentary:
;;; A reduced but complete (for my uses) config,
;;; based on spacemacs

;;; Code:


;; ;;; ----------- straight.el bootstrap -----------
;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 5))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))
;; ;;; --------- straight.el bootstrap end ---------

(require 'package)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ;("marmalade" . "http://marmalade-repo.org/packages/")
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
(require 'setup-helm-gtags)
(require 'setup-editing)
(require 'setup-c)
(require 'setup-php)
;; (require 'setup-lisp)
;; (require 'setup-prolog)
(require 'setup-terminal) ;; Setup for using emacs in a terninal as well as a terminal in emacs
(require 'setup-programming)

(set-face-attribute 'default nil :height 120)

(add-to-list 'auto-mode-alist '("\\.tsx$" . rjsx-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(create-lockfiles nil)
 '(custom-enabled-themes '(tango-dark))
 '(flycheck-phpstan-executable "\"/home/hugo/software/social/bin/phpstan\"")
 '(folding-internal-margins nil)
 '(ggtags-enable-navigation-keys nil)
 '(ggtags-extra-args '("--skip-unreadable"))
 '(ggtags-sort-by-nearness t)
 '(ggtags-use-idutils t)
 '(package-selected-packages
   '(typescript-mode straight rainbow-mode gruber-darker-theme hideshowvis hs-minor-mode neon-mode php-align flycheck-phpstan phpstan lsp-mode vue-mode po-mode cmake-mode pdf-tools duplicate-thing zygospore xclip ws-butler web-mode volatile-highlights use-package undo-tree twig-mode tramp-auto-auth sql-indent smartparens smart-tabs-mode rebox2 pandoc-mode pandoc multiple-cursors material-theme markdown-mode+ iedit highlight-indent-guides helm-tramp helm-swoop helm-projectile helm-gtags helm-company haskell-mode gmpl-mode ggtags folding fold-dwim flycheck ewal-spacemacs-themes ewal-doom-themes elpy dumb-jump dtrt-indent drag-stuff dockerfile-mode docker-compose-mode company-php company-irony-c-headers company-irony company-c-headers comment-dwim-2 clean-aindent-mode auctex anzu ac-php))
 '(safe-local-variable-values '((php-project-root . auto)))
 '(sgml-basic-offset 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;; init.el ends here

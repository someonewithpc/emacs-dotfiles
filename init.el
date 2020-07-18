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
(require 'setup-helm-gtags)
(require 'setup-ggtags)
(require 'setup-editing)
(require 'setup-c)
(require 'setup-php)
;; (require 'setup-lisp)
;; (require 'setup-prolog)
(require 'setup-terminal) ;; Setup for using emacs in a terninal as well as a terminal in emacs
(require 'setup-programming)

(global-set-key (kbd "C-c C-$") 'toggle-truncate-lines)

;; Horizontal scrolling mouse events should actually scroll left and right.
(global-set-key (kbd "<mouse-6>") (lambda () (interactive)
				    (if truncate-lines (scroll-right 1))))
(global-set-key (kbd "<mouse-7>") (lambda () (interactive)
				    (if truncate-lines (scroll-left 1))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "2a749c20af891c16571527d07976bbcf2bf31819fa7d322942b73386019f4d58" "6177ecbffb8f37756012c9ee9fd73fc043520836d254397566e37c6204118852" "34b3219ae11acd81b2bb7f3f360505019f17d7a486deb8bb9c1b6d13c6616d2e" "9b272154fb77a926f52f2756ed5872877ad8d73d018a426d44c6083d1ed972b1" "e2acbf379aa541e07373395b977a99c878c30f20c3761aac23e9223345526bcc" "632694fd8a835e85bcc8b7bb5c1df1a0164689bc6009864faed38a9142b97057" "a92e9da0fab90cbec4af4a2035602208cebf3d071ea547157b2bfc5d9bd4d48d" "3d3807f1070bb91a68d6638a708ee09e63c0825ad21809c87138e676a60bda5d" "912cac216b96560654f4f15a3a4d8ba47d9c604cbc3b04801e465fb67a0234f0" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "d71aabbbd692b54b6263bfe016607f93553ea214bc1435d17de98894a5c3a086" "3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "9b01a258b57067426cc3c8155330b0381ae0d8dd41d5345b5eddac69f40d409b" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" "2035a16494e06636134de6d572ec47c30e26c3447eafeb6d3a9e8aee73732396" "8a379e7ac3a57e64de672dd744d4730b3bdb88ae328e8106f95cd81cbd44e0b6" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "41098e2f8fa67dc51bbe89cce4fb7109f53a164e3a92356964c72f76d068587e" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(flycheck-check-syntax-automatically (quote (save idle-change)))
 '(flycheck-clang-args nil)
 '(flycheck-gcc-language-standard "c++20")
 '(flycheck-idle-change-delay 1)
 '(package-selected-packages
   (quote
    (ewal-doom-themes ewal-spacemacs-themes twig-mode tramp-auto-auth helm-tramp haskell-mode markdown-mode+ pandoc pandoc-mode folding fold-dwim gmpl-mode dockerfile-mode docker-compose-mode material-theme elpy multiple-cursors auto-sudoedit sudo-edit drag-stuff dumb-jump web-mode php-mode sql-indent longlines-mode longlines longlinnes-mode auctex smart-tabs-mode smart-tabs ediprolog semantic-bovine company-irony company-irony-c-headers function-args funtion-args linum-relative highlight-indent-guides highlight-indent-guide indent-guie prolog-mode flycheck smartparens multi-term spacemacs-theme rebox rebox2 helm-company iedit anzu comment-dwim-2 ws-butler dtrt-indent clean-aindent-mode yasnippet undo-tree volatile-highlights helm-gtags helm-projectile helm-swoop helm zygospore projectile company use-package)))
 '(prolog-paren-indent-p t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

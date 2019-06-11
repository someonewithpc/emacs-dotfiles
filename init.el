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

;; (setq debug-on-error t)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t) ;; Install from repo if not yet available

;; Require "layers"
(require 'setup-general)
(require 'setup-helm)
(require 'setup-helm-gtags)
;; (require 'setup-ggtags)
(require 'setup-editing)
(require 'setup-c)
(require 'setup-lisp)
(require 'setup-prolog)
(require 'setup-terminal) ;; Setup for using emacs in a terninal as well as a terminal in emacs
(require 'setup-programming)
(require 'setup-latex)

;; (use-package sudo-edit)
;; (use-package auto-sudoedit
;;   :init (auto-sudoedit-mode 1))

(use-package multiple-cursors
  :bind (("C-S-c C-S-c"     . mc/edit-lines)
         ("C-S-<down>"      . mc/mark-next-like-this)
         ("C-S-<up>"        . mc/mark-previous-like-this)
         ("<C-S-kp-insert>" . mc/mark-all-like-this)))

(use-package xclip
  :config (xclip-mode))

(use-package dumb-jump
  :config
  (setq dumb-jump-selector 'helm)
  (setq dumb-jump-prefer-searcher 'ag))

(use-package drag-stuff
  :bind (("M-S-<up>" . drag-stuff-up)
         ("M-S-<down>" . drag-stuff-down)
         ("M-S-<left>" . drag-stuff-left)
         ("M-S-<right>" . drag-stuff-right)))

(add-to-list 'load-path "~/.emacs.d/extern/spacemacs-theme/")
(require 'spacemacs-dark-theme)

(set-register ?e '(file . "~/.emacs.d/init.el"))

(when (display-graphic-p)
  (unbind-key (kbd "C-z")) ;; Disable suspend-frame in graphical mode. Still useful in terminal mode, though
  )

(global-set-key (kbd "<M-up>") 'scroll-up-line)
(global-set-key (kbd "<M-down>") 'scroll-down-line)
(global-set-key (kbd "C-j") 'join-line)
(global-set-key (kbd "C-x SPC") 'cua-rectangle-mark-mode)
(global-set-key (kbd "M-c") 'upcase-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)

(defun buffer-binary-p (&optional buffer)
  "Return whether BUFFER or the current buffer is binary.

A binary buffer is defined as containing at least on null byte.

Returns either nil, or the position of the first null byte."
  (with-current-buffer (or buffer (current-buffer))
    (save-excursion
      (goto-char (point-min))
      (search-forward (string ?\x00) nil t 1))))

(defun hexl-if-binary ()
  "If `hexl-mode' is not already active, and the current buffer
is binary, activate `hexl-mode'."
  (interactive)
  (unless (eq major-mode 'hexl-mode)
    (when (buffer-binary-p)
      (hexl-mode))))

(add-hook 'find-file-hooks 'hexl-if-binary)

;; (global-unset-key (kbd "\\"))

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
 '(TeX-view-program-list
   (quote
    ((""
      ("")
      "")
     ("Atril"
      ("atril --page-index=%(outpage) %o")
      "atril"))))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(flycheck-check-syntax-automatically (quote (save idle-change)))
 '(flycheck-clang-args nil)
 '(flycheck-idle-change-delay 1)
 '(package-selected-packages
   (quote
    (multiple-cursors auto-sudoedit sudo-edit drag-stuff dumb-jump web-mode php-mode sql-indent longlines-mode longlines longlinnes-mode auctex smart-tabs-mode smart-tabs ediprolog semantic-bovine company-irony company-irony-c-headers function-args funtion-args linum-relative highlight-indent-guides highlight-indent-guide indent-guie prolog-mode flycheck smartparens multi-term spacemacs-theme rebox rebox2 origami helm-company iedit anzu comment-dwim-2 ws-butler dtrt-indent clean-aindent-mode yasnippet undo-tree volatile-highlights helm-gtags helm-projectile helm-swoop helm zygospore projectile company use-package)))
 '(prolog-paren-indent-p t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)

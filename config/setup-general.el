
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(blink-cursor-mode 0)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Package to make C-x 1 toggle between collapsing and showing other windows
(use-package zygospore
  :bind (("C-x 1" . zygospore-toggle-delete-other-windows))
  )

;; GROUP: Editing -> Editing Basics
(setq global-mark-ring-max 5000         ; increase mark ring to contains 5000 entries
      mark-ring-max 5000                ; increase kill ring to contains 5000 entries
      mode-require-final-newline t      ; add a newline to end of file
      tab-width 8                       ; default to 8 visible spaces to display a tab
      kill-ring-max 5000                ; increase kill-ring capacity
      kill-whole-line t                 ; if NIL, kill whole line and move the next line up
      )

(add-hook 'sh-mode-hook (lambda ()
                          (setq tab-width 4)))

(delete-selection-mode)			; Make inserting replace selected text

;; show whitespace in diff-mode
(add-hook 'diff-mode-hook (lambda ()
                            (setq-local whitespace-style
                                        '(face tabs tab-mark spaces space-mark trailing
                                               indentation::space indentation::tab
                                               newline newline-mark))
                            (whitespace-mode 1)))

;; Package: volatile-highlights
;; GROUP: Editing -> Volatile Highlights
(use-package volatile-highlights
  :init
  (volatile-highlights-mode t)
  (vhl/define-extension 'undo-tree 'undo-tree-yank 'undo-tree-move)
  (vhl/install-extension 'undo-tree)
  )

(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(use-package yasnippet
  :defer t
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode))

(use-package clean-aindent-mode
  :init
  (add-hook 'prog-mode-hook 'clean-aindent-mode)
  (global-set-key (kbd "RET") 'newline-and-indent) ;; Using comment-indent-new-line
  )

(use-package dtrt-indent
  :init
  (dtrt-indent-mode 1)
  (setq dtrt-indent-verbosity 0))

 ;; whitespace-butler - cleanly clean trailing whitespace
(use-package ws-butler
  :init
  (add-hook 'prog-mode-hook 'ws-butler-mode)
  (add-hook 'text-mode 'ws-butler-mode)
  (add-hook 'fundamental-mode 'ws-butler-mode))

(use-package comment-dwim-2
  :bind (("M-;" . comment-dwim-2))
  :config
  (setq comment-dwim-2--inline-comment-behavior 'reindent-comment)
  )

(use-package anzu			;Display number of matches in search
  :init
  (global-anzu-mode)
  (global-set-key (kbd "M-%") 'anzu-query-replace)
  (global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp))

;; PACKAGE: iedit
(use-package iedit
  :bind (("C-;" . iedit-mode))
  :init
  (setq iedit-toggle-key-default nil))

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)
;; automatically indent when press RET
;;(global-set-key (kbd "RET") 'comment-indent-new-line) ;; 'newline-and-indent)

(windmove-default-keybindings) ;; Shift + arrows to change between windows

(provide 'setup-general)

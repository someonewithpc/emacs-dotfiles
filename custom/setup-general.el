(menu-bar-mode -1)
(tool-bar-mode -1)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Package zygospore
(use-package zygospore
  :bind (("C-x 1" . zygospore-toggle-delete-other-windows))
  )

(use-package rebox2
  :bind (:map c-mode-base-map ("M-q" . rebox-dwim))
  )

(use-package smartparens
  :config (smartparens-global-mode)
          (smartparens-strict-mode))

(show-paren-mode)

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)
;; automatically indent when press RET
(global-set-key (kbd "RET") 'comment-indent-new-line) ;; 'newline-and-indent)

(windmove-default-keybindings) ;; Shift + arrows to change between windows

(provide 'setup-general)

(unless (display-graphic-p)
    (use-package xclip
    :defer 0.5
    :config (xclip-mode)
    :hook (kill-emacs . (lambda ()
			  (when (fboundp 'xclip-deactivate) (xclip-deactivate))
			  (xclip-mode -1)))
    )
  )

;; Package to make C-x 1 toggle between collapsing and showing other windows
(use-package zygospore
  :bind (("C-x 1" . zygospore-toggle-delete-other-windows))
  )

(use-package whitespace-mode
  :hook (diff-mode . whitespace-mode)
  :bind ("C-c w" . 'whitespace-mode)
  )

(use-package volatile-highlights
  :after (unto-tree)
  :hook (after-init . volatile-highlights-mode)
  :config
  (vhl/define-extension 'undo-tree 'undo-tree-yank 'undo-tree-move)
  (vhl/install-extension 'undo-tree)
  )

(use-package ws-butler
  :hook (after-init . ws-butler-global-mode)
  :config
  (setq-default show-trailing-whitespace t)
  )

;; Display number of matches in search
(use-package anzu
  :defer 1
  :bind (([remap query-replace] . anzu-replace-at-cursor-thing)
	 ([remap query-replace-regexp] . anzu-query-replace-regexp)
	 ([remap isearch-query-replace] . anzu-isearch-query-replace)
	 ([remap isearch-query-replace-regexp] . anzu-isearch-query-replace-regexp))
  :config (global-anzu-mode))

(use-package windmove
  :config (windmove-default-keybindings))

;; -------- Helm -----------

(use-package helm
  :init
  (setq helm-M-x-fuzzy-match t
        helm-mode-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-locate-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-completion-in-region-fuzzy-match t
        helm-candidate-number-list 150
        helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t
        helm-echo-input-in-header-line t
        helm-autoresize-max-height 0
        helm-autoresize-min-height 40)
  :config
  (helm-mode 1)
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list)
         ("C-x r b" . helm-bookmarks)
         ("M-y" . helm-show-kill-ring)
         ("C-h SPC" . helm-all-mark-rings)
         :map helm-map
         ;;  Swap <tab> and C-j
         ("C-j" . 'helm-select-action)
         ("<tab>" . 'helm-execute-persistent-action)
         ))

(use-package helm-projectile
  :after (helm projectile)
  :bind (("C-x C-d" . helm-projectile))
  )

(use-package helm-rg
  :after helm
  :bind (("C-x a" . (lambda ()
                      "Use `helm-rg' to search for a pattern in the current project."
                      (interactive)
                      (let ((default-directory (projectile-project-root)))
                        (helm-rg nil)))))
  )

(use-package helm-swoop
  :after helm
  :bind (("M-i" . helm-swoop)
         ("M-I" . helm-swoop-back-to-last-point)
         ("C-c M-i" . helm-multi-swoop)
         ("C-x M-i" . helm-multi-swoop-all)))

(use-package helm-descbinds
  :after helm
  :config (helm-descbinds-mode))


(use-package projectile
  :config
  (projectile-mode +1))

(provide 'interface)

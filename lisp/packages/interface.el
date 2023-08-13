(when (not (eq window-system 'x))
  (use-package xclip
    :defer 0.5
    :config (xclip-mode))
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

(provide 'interface)

(use-package undo-tree
  :hook (after-init . global-undo-tree-mode)
  :config
  (setq backup-directory-alist `(("." . ,(expand-file-name "local/tmp/backups/" user-emacs-directory)))
	auto-save-file-name-transforms `((".*" ,(expand-file-name "local/tmp/autosaves/" user-emacs-directory) t))
	undo-tree-history-directory-alist `(("." . ,(expand-file-name "local/tmp/undo-tree/" user-emacs-directory))))
  )

(use-package iedit
  :defer 3
  :bind (("C-;" . iedit-mode))
  :init
  (setq iedit-toggle-key-default nil))

(use-package tramp
  :straight nil
  :init (require 'tramp-compat)
  )

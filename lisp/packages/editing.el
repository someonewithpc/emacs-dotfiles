(use-package undo-tree
  :hook (after-init . global-undo-tree-mode))

(use-package iedit
  :defer 3
  :bind (("C-;" . iedit-mode))
  :init
  (setq iedit-toggle-key-default nil))

(use-package tramp
  :straight nil
  :init (require 'tramp-compat)
  )

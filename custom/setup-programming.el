
;;; Code:
(use-package highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'character)
  :init
  (highlight-indent-guides-mode)
  )

(use-package company
  :ensure t
  :init
  (global-company-mode)
  :bind (("<backtab>" . company-complete-common-or-cycle))
  :config
  ;; (delete 'company-backends 'company-clang)
  )

;; origami for folding source code
(use-package origami
  :hook c-mode-hook
  :bind (:map origami-mode-map
              ("C-c o S" . origami-show-node)
              ("C-c o H" . origami-close-node)
              )
  )

(use-package linum-relative
  :init (linum-relative-global-mode))

(provide 'setup-programming)

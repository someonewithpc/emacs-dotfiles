
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

(use-package rebox2
  :bind (:map c-mode-base-map ("M-q" . rebox-dwim))
  )

(use-package smartparens
  :config (smartparens-global-mode)
  (smartparens-strict-mode)
  ;; pair "`" with "'" in emacs-lisp-mode
  ;; (sp-with-modes sp-lisp-modes
  ;;   ;; disable ', it's the quote character!
  ;;   (sp-local-pair "'" nil :actions nil))
  ;;(sp-local-pair 'emacs-lisp-mode "`" "'")
  ;; no '' pair in emacs-lisp-mode
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  )

(show-paren-mode)

(use-package flycheck
  :config
  (global-flycheck-mode)
  (setq sentence-end-double-space nil))

(provide 'setup-programming)

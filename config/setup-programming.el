
;;; Code:

(use-package highlight-indent-guides
  :defer 1
  :hook (prog-mode . highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'character)
  )

;; (use-package company
;;   :ensure t
;;   :init
;;   (global-company-mode)
;;   :bind (("<backtab>" . company-complete-common-or-cycle))
;;   :config
;;   ;; (delete 'company-backends 'company-clang)
;;   )

(use-package smartparens
  :defer 1
  :config (smartparens-global-mode)
  ;; pair "`" with "'" in emacs-lisp-mode
  ;; (sp-with-modes sp-lisp-modes
  ;;   ;; disable ', it's the quote character!
  ;;   (sp-local-pair "'" nil :actions nil))
  ;;(sp-local-pair 'emacs-lisp-mode "`" "'")
  ;; no '' pair in emacs-lisp-mode
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  :init
  (smartparens-strict-mode)
  )

(show-paren-mode)

(use-package flycheck
  :defer 1
  :config
  (global-flycheck-mode)
  (setq sentence-end-double-space nil))

;; (use-package smart-tabs-mode
;;   :config
;;   (setq-default indent-tabs-mode nil)
;;   :init
;;   (smart-tabs-insinuate 'c 'c++ 'java)
;;   :hook
;;   (c-mode-common-hook . (lambda () (setq indent-tabs-mode t))))

(add-hook 'prog-mode 'hs-minor-mode)

(use-package folding
  :hook (php-mode . folding-mode)
  )

(provide 'setup-programming)

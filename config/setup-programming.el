
;;; Code:

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'character)
  )

(use-package company
  :ensure t
  :init
  (global-company-mode)
  :bind (("<backtab>" . company-complete-common-or-cycle))
  :config
  ;; (delete 'company-backends 'company-clang)
  )

(use-package smartparens
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

(use-package folding
  :hook (php-mode . folding-mode)
  :bind (("C-c <tab>" . folding-toggle-show-hide)
         ("C-c <C-tab>" . folding-whole-buffer))
  :config (add-to-list 'after-save-hook 'folding-whole-buffer)
  )


(provide 'setup-programming)

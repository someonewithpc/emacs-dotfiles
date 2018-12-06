(use-package company
  :requires lisp-mode
  :init
  (global-company-mode 1)
  :bind (:map emacs-lisp-mode-map ([C-tab] . 'company-complete))
  ;; (delete 'company-semantic company-backends)
  )

;; (define-key c-mode-map  [(control tab)] 'company-complete)
;; (define-key c++-mode-map  [(control tab)] 'company-complete)

(use-package helm-company
  :requires 'company
  :bind (:map company-mode-map ("C-:" . 'helm-company)
	      :map company-active-map ("C-:" . 'helm-company))
  )


(provide 'setup-lisp)

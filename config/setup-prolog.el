
;;; Code:

(use-package prolog ;; Replacing the builtin one wouldn't work without renaming it
  ;; :load-path "./extern/"
  :config
  (add-to-list 'auto-mode-alist '("\\.pro\\'" . prolog-mode))
  (setq prolog-system 'swi
	prolog-program-switches '((swi ("-G128M" "-T128M" "-L128M" "-O"))
                                  (t nil)))
  )

(use-package ediprolog
  :load-path "./extern/"
  :after (prolog)
  :hook (prolog-mode)
  :bind (:map prolog-mode-map ("C-x C-e" . ediprolog-dwim))
  )

(provide 'setup-prolog)

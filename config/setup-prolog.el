
;;; Code:

(use-package prolog2
  :load-path "./extern/"
  :config
  (add-to-list 'auto-mode-alist '("\\.pro\\'" . prolog-mode))
  (setq prolog-system 'swi
	prolog-program-switches '((swi ("-G128M" "-T128M" "-L128M" "-O"))
                                  (t nil)))
  )

(use-package ediprolog
  :load-path "./extern/"
  :after (prolog2)
  :hook (prolog-mode)
  :bind (:map prolog-mode-map ("C-x C-e" . ediprolog-dwim))
  :config
  ;; (defun my-ediprolog-dwim ()
  ;;   (interactive)
  ;;   (ediprolog-consult)
  ;;   (setq ediprolog-consult-window (display-buffer ediprolog-consult-buffer))
  ;;   (set-window-dedicated-p ediprolog-consult-window nil)
  ;;   (ediprolog-dwim)
  ;;   )
  )

(provide 'setup-prolog)

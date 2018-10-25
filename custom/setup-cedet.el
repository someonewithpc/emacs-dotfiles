;; (require 'cc-mode)
(use-package semantic
  :config (progn (global-semanticdb-minor-mode 1)
	       (global-semantic-idle-scheduler-mode 1)
	       (global-semantic-stickyfunc-mode 1)
	       (semantic-mode 1))
  )

;; (defun alexott/cedet-hook ()
;; ;; Enable EDE only in C/C++
;;   (require 'ede)
;;   (global-ede-mode)
;;   (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
;;   (local-set-key "\C-c\C-s" 'semantic-ia-show-summary))

;; (add-hook 'c-mode-common-hook 'alexott/cedet-hook)
;; (add-hook 'c-mode-hook 'alexott/cedet-hook)
;; (add-hook 'c++-mode-hook 'alexott/cedet-hook)

(use-package ede
  :requires cc-mode
  :init (global-ede-mode)
  :hook (c-mode-common-hook c-mode-hook c++-mode-hook)
  :bind (("C-c C-j" . semantic-ia-fast-jump)
         :map c-mode-base-map ("C-c C-s" . semantic-ia-show-summary))
  )


(provide 'setup-cedet)

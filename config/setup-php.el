
;;; Code:

(use-package sql-indent)
(use-package php-mode)
(use-package web-mode)

(use-package ac-php-core)
(use-package ac-php)

;; (use-package company-php
;;   :after (php company)
;;   :bind (:map php-mode-map
;;               ([C-tab] . company-complete))
;;   :config (add-to-list 'company-backends ('company-ac-php-backend 'company-my-php-backend)))


;; (defun company-my-php-backend(command &optional arg &rest ignored)
;;   "Custom company backend for PHP. (COMMAND ARG IGNORED)."
;;   (case command
;;     (prefix (and (eq major-mode 'php-mode)
;;                  (company-grab-symbol)))
;;     (sorted t)
;;     (candidates (all-completions
;;                  arg
;;                  (if (and (boundp 'my-php-symbol-hash)
;;                           my-php-symbol-hash)
;;                      my-php-symbol-hash
;;                    (with-temp-buffer
;;                      (call-process-shell-command
;;                       "php -r '$all=get_defined_functions();foreach ($all[\"internal\"] as $fun) { echo $fun . \";\";};'" nil t)
;;                      (goto-char (point-min))
;;                      (let ((hash (make-hash-table)))
;;                        (while (re-search-forward "\\([^;]+\\);" (point-max) t)
;;                          (puthash (match-string 1) t hash))
;;                        (setq my-php-symbol-hash hash))))))))

(add-hook 'php-mode-hook
          (lambda ()
            (require 'php-align)
            (php-align-setup)
            (add-hook 'after-save-hook (lambda () (revert-buffer t t t) (folding-whole-buffer)))))

(define-key php-mode-map (kbd "C-c C-d") nil)

;; (require 'php-cs-fixer "~/.emacs.d/extern/php-cs-fixer/php-cs-fixer.el")
;; (add-hook 'after-save-hook 'php-cs-fixer-after-save)

(provide 'setup-php)
;;; setup-php.el ends here

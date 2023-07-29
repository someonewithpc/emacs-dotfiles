;;; straight.el --- Setup straight.el

(defvar*
  '(straight-check-for-modifications . '(check-on-save))
  '(straight-use-package-by-default . t)
  '(straight-host-usernames . '((github . "someonewithpc")
                                (gitlab . "someonewithpc")
                                (codeberg . "someonewithpc")))
  '(straight-base-dir (locate-user-emacs-file "./local/straight/"))
  '(use-package-always-ensure . nil)
  )

(defvar bootstrap-version)
(let ((bootstrap-file (locate-user-emacs-file "./local/straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil (not init-file-debug) nil 'must-suffix))

(straight-use-package 'use-package)

(provide 'straight)
;;; straight.el ends here

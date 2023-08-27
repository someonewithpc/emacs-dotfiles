(dolist (file `(interface editing programming))
  (load (expand-file-name (file-name-concat "lisp/packages/" (symbol-name file)) user-emacs-directory) nil (not init-file-debug) nil 'must-suffix)
  )

(use-package conf-mode)

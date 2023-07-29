;;; utils.el --- Utility functions -*- lexical-binding: t; -*-

(defun defvar* (vars)
  (dolist (var-val vars)
    (defvar (car var-val) (cdr var-val))))

(provide 'utils)
;;; utils.el ends here

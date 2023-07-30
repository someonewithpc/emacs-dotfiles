;;; utils.el --- Utility functions -*- lexical-binding: t; -*-

(defmacro defvar* (&rest vars)
  `(progn
     ,@(mapcar (lambda (var)
                 `(eval '(defvar ,(car var) ,(cadr var))))
               vars)))

(defmacro eval-when! (cond &rest body)
  "Expands to BODY if CONDITION is non-nil at compile/expansion time.
See `eval-if!' for details on this macro's purpose."
  (declare (indent 1))
  (when (eval cond)
    (macroexp-progn body)))

(provide 'utils)
;;; utils.el ends here

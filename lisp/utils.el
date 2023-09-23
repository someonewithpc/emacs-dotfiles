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

(defun apply-partially-right (fun &rest args)
  "Return a function that is a partial application of FUN to ARGS.
ARGS are applied to the right of any arguments provided later."
  (lambda (&rest front-args)
    (apply fun (append front-args args))))

(defun xor (a b)
  (or (and a (not b))
      (and (not a) b)))

(provide 'utils)
;;; utils.el ends here

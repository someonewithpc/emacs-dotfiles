;;; init.el --- Description -*- lexical-binding: t; -*-

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(load (expand-file-name "lisp/defaults" user-emacs-directory) nil (not init-file-debug) nil 'must-suffix)

;; From Doom Emacs (MIT license)
;; PERF: `file-name-handler-alist' is consulted on each call to `require',
;;   `load', or various file/io functions (like `expand-file-name' or
;;   `file-remote-p'). You get a noteable boost to startup time by unsetting
;;   or simplifying its value.
(let ((old-value (default-toplevel-value 'file-name-handler-alist)))
  (setq file-name-handler-alist
        ;; HACK: If the bundled elisp for this Emacs install isn't
        ;;   byte-compiled (but is compressed), then leave the gzip file
        ;;   handler there so Emacs won't forget how to read read them.
        ;;
        ;;   calc-loaddefs.el is our heuristic for this because it is built-in
        ;;   to all supported versions of Emacs, and calc.el explicitly loads
        ;;   it uncompiled. This ensures that the only other, possible
        ;;   fallback would be calc-loaddefs.el.gz.
        (if (eval-when-compile
              (locate-file-internal "calc-loaddefs.el" load-path))
            nil
          (list (rassq 'jka-compr-handler old-value))))
  ;; Make sure the new value survives any current let-binding.
  (set-default-toplevel-value 'file-name-handler-alist file-name-handler-alist)
  ;; Remember it so it can be reset where needed.
  (put 'file-name-handler-alist 'initial-value old-value)
  ;; COMPAT: ...but restore `file-name-handler-alist' later, because it is
  ;;   needed for handling encrypted or compressed files, among other things.
  (add-hook! 'emacs-startup-hook :depth 101
    (defun doom--reset-file-handler-alist-h ()
      (setq file-name-handler-alist
            ;; Merge instead of overwrite because there may have been changes to
            ;; `file-name-handler-alist' since startup we want to preserve.
            (delete-dups (append file-name-handler-alist old-value))))))



;; ;; The GC introduces annoying pauses and stuttering into our Emacs experience,
;; ;; so we use `gcmh' to stave off the GC while we're using Emacs, and provoke it
;; ;; when it's idle. However, if the idle delay is too long, we run the risk of
;; ;; runaway memory usage in busy sessions. If it's too low, then we may as well
;; ;; not be using gcmh at all.
;; (setq gcmh-idle-delay 'auto  ; default is 15s
;;       gcmh-auto-idle-delay-factor 10
;;       gcmh-high-cons-threshold (* 16 1024 1024))  ; 16mb
;; (add-hook 'doom-first-buffer-hook #'gcmh-mode)

;; gcmh-mode



;;; init.el ends here

;;; init.el --- Description -*- lexical-binding: t; -*-

(add-to-list 'load-path (locate-user-emacs-file "lisp/"))

(dolist (file `(utils defaults automode straight ,@(when noninteractive '(trigger-compilation)) benchmark))
  (load (expand-file-name (file-name-concat "lisp/" (symbol-name file)) user-emacs-directory) nil (not init-file-debug) nil 'must-suffix)
  )


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

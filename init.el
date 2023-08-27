;;; init.el --- Description -*- lexical-binding: t; -*-

(add-to-list 'load-path (file-name-as-directory (locate-user-emacs-file "lisp/")))
(let ((eln-cache-dir (concat (file-name-as-directory user-emacs-directory) "local/eln-cache")))
  (when (file-directory-p eln-cache-dir)
    (add-to-list 'load-path (car (directory-files eln-cache-dir t "^[^.]")))))

;; (load "/home/hugo/projects/emacs-dotfiles/local/eln-cache/30.0.50-fba4a546/utils-ac515563-8f9b87fe.eln")

(dolist (file `(utils defaults automode straight theme packages ,@(when noninteractive '(trigger-compilation)) keybinds benchmark))
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

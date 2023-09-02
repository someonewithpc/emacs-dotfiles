;; ;; The GC introduces annoying pauses and stuttering into our Emacs experience,
;; ;; so we use `gcmh' to stave off the GC while we're using Emacs, and provoke it
;; ;; when it's idle. However, if the idle delay is too long, we run the risk of
;; ;; runaway memory usage in busy sessions. If it's too low, then we may as well
;; ;; not be using gcmh at all.
(use-package gcmh
  :hook (emacs-startup . gcmh-mode)
  :config (setq gcmh-idle-delay 'auto  ; default is 15s
                gcmh-auto-idle-delay-factor 10
                gcmh-high-cons-threshold (* 512 1024 1024))  ; 16mb
  )

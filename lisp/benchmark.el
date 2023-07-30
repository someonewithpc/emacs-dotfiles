;;; benchmark.el --- Print the startup time -*- lexical-binding: t; -*-

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Doom loaded %d packages in %.03fs"
                     (- (length load-path) (length (get 'load-path 'initial-value)))
                      (float-time (time-subtract (current-time) before-init-time))))
          100)

(provide 'benchmark)
;;; benchmark.el ends here

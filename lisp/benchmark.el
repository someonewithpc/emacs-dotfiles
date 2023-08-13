;;; benchmark.el --- Print the startup time -*- lexical-binding: t; -*-

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs loaded %d packages in %.03fs"
                     (- (length load-path) (length (get 'load-path 'initial-value)))
                     (float-time (time-subtract (current-time) before-init-time)))
	    (when init-file-debug
	      (pp (mapcar 'car (seq-filter (lambda (entry)
					     (and (car entry)
						  (not (string-suffix-p ".eln" (car entry)))))
					   load-history)))
	      )
	    )
          100)

(provide 'benchmark)
;;; benchmark.el ends here

;;; compile.el --- Register all files for compilation -*- lexical-binding: t; -*-

;;; Code:

(require 'comp)

(setq native-comp-jit-compilation t
      native-comp-async-report-warnings-errors nil
      native-comp-speed 3 ;; -O3
      native-comp-enable-subr-trampolines t
      native-comp-jit-compilation-deny-list (append native-comp-jit-compilation-deny-list ".*/tests?/.*")
      inhibit-message nil
      )

;; Use async version as it can recurse
(native-compile-async user-emacs-directory 'recursively nil
                      (lambda (file)
                        (let ((should (not (string-match-p "/tests?/" file))))
                          (if should (message "Will compile %s" file)
                            (when (getenv "DEBUG") (message "Ignoring %s" file)))
                          should)))

;; but block until native compilation has finished
(while (or comp-files-queue (> (comp-async-runnings) 0))
  (sleep-for 1))

(message "Compilation finished!")

(provide 'trigger-compilation)
;;; trigger-compilation.el ends here

;;; compile.el --- Register all files for compilation -*- lexical-binding: t; -*-

;;; Code:

(setq native-comp-jit-compilation t
      native-comp-async-report-warnings-errors nil
      inhibit-message nil)

(native-compile-async user-emacs-directory 'recursively nil
                      (lambda (file)
                        (let ((should (not (string-match-p "/tests?/" file))))
                          (if should (message "Compiling %s" file)
                            (when (getenv "DEBUG") (message "Ignoring %s" file)))
                          should)))

(while (> (hash-table-count comp-deferred-pending-h) 0)
  (message "Waiting for compilation to finish...")
  (sit-for 1))

(message "Compilation finished!")

(provide 'trigger-compilation)
;;; trigger-compilation.el ends here

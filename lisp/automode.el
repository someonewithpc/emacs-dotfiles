;;; automode.el --- Automode definitions -*- lexical-binding: t; -*-

;;; Support for more file extensions
;; Add support for additional file extensions.
(dolist (entry '(("/LICENSE\\'" . text-mode)
                 ("\\.log\\'" . text-mode)
                 ("rc\\'" . conf-mode)
                 ("\\.hex\\'" . hexl-mode)
                 ("CMakeLists\\.txt\\'" . cmake-ts-mode)
                 ("\\.cmake\\'" . cmake-ts-mode)))
  (push entry auto-mode-alist))

(provide 'automode)
;;; automode.el ends here

;;; init.el --- Description -*- lexical-binding: t; -*-

(add-to-list 'load-path (file-name-as-directory (locate-user-emacs-file "lisp/")))
(let ((eln-cache-dir (concat (file-name-as-directory user-emacs-directory) "local/eln-cache")))
  (when (file-directory-p eln-cache-dir)
    (add-to-list 'load-path (car (directory-files eln-cache-dir t "^[^.]")))))

;; (load "/home/hugo/projects/emacs-dotfiles/local/eln-cache/30.0.50-fba4a546/utils-ac515563-8f9b87fe.eln")

(dolist (file `(utils defaults automode straight theme packages ,@(when noninteractive '(trigger-compilation)) keybinds benchmark))
  (load (expand-file-name (file-name-concat "lisp/" (symbol-name file)) user-emacs-directory) nil (not init-file-debug) nil 'must-suffix)
  )

;;; init.el ends here

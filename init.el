;;; init.el --- Description -*- lexical-binding: t; -*-

;; (load "/home/hugo/projects/emacs-dotfiles/local/eln-cache/30.0.50-fba4a546/utils-ac515563-8f9b87fe.eln")

(dolist (file `(utils defaults automode straight theme packages ,@(when noninteractive '(trigger-compilation)) keybinds benchmark))
  (load (expand-file-name (file-name-concat "lisp/" (symbol-name file)) user-emacs-directory) nil (not init-file-debug) nil 'must-suffix)
  )

;;; init.el ends here

(use-package undo-tree
  :hook (after-init . global-undo-tree-mode)
  :config
  (dolist (folder '(backups autosaves undo-tree))
    (let ((dir (expand-file-name (file-name-concat "local/tmp/" (symbol-name folder)) user-emacs-directory)))
      (unless (file-exists-p dir)
        (make-directory dir t))))
  (setq backup-directory-alist `(("." . ,(expand-file-name "local/tmp/backups/" user-emacs-directory)))
	auto-save-file-name-transforms `((".*" ,(expand-file-name "local/tmp/autosaves/" user-emacs-directory) t))
	undo-tree-history-directory-alist `(("." . ,(expand-file-name "local/tmp/undo-tree/" user-emacs-directory))))
  )

(use-package iedit
  :defer 3
  :bind (("C-;" . iedit-mode))
  :init
  (setq iedit-toggle-key-default nil))

(use-package tramp
  :straight nil
  :init (require 'tramp-compat)
  )

(use-package hexl
  :commands (hexl-mode)
  :hook
  (find-file . (lambda ()
		 "Use hexl-mode if opening a binary file (containing NUL bytes)"
		 (unless (eq major-mode 'hexl-mode)
		   (when (save-excursion
			   (goto-char (point-min))
			   (search-forward (string ?\x00) nil t 1))
		     (hexl-mode)))
		 ))
  )

(use-package string-inflection
  :init (defvar custom--string-inflection-invoked-with-universal-argument-point nil "Remember if the last invocation was with a universal argument.")
  :bind ("M-c" . (lambda ()
		   (interactive)
		   (if (or current-prefix-arg (eq custom--string-inflection-invoked-with-universal-argument-point (point)))
		       (progn
			 (setq custom--string-inflection-invoked-with-universal-argument-point (point))
			 (string-inflection-all-cycle)
			 (goto-char custom--string-inflection-invoked-with-universal-argument-point))
		     (setq custom--string-inflection-invoked-with-universal-argument-point nil)
		     (upcase-char 1))))
  )

; setFooBar

(use-package wucuo
  :hook ((prog-mode text-mode) . wucuo-start)
  :config (setq wucuo-flyspell-start-mode "fast"
		wucuo-update-interval 0.5
		ispell-program-name "aspell"
		ispell-extra-args '("--run-together"))
  )

(use-package drag-stuff
  :hook (emacs-startup . drag-stuff-mode)
  :bind (("M-S-<up>" . drag-stuff-up)
         ("M-S-<down>" . drag-stuff-down)
         ("M-S-<left>" . drag-stuff-left)
         ("M-S-<right>" . drag-stuff-right))
  )

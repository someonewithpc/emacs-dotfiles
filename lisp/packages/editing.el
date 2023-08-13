(use-package undo-tree
  :hook (after-init . global-undo-tree-mode)
  :config
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

(use-package wucuo
  :hook ((prog-mode text-mode) . wucuo-start)
  :config (setq wucuo-flyspell-start-mode "fast"
		wucuo-update-interval 0.5
		ispell-program-name "aspell"
		ispell-extra-args '("--run-together"))
  )

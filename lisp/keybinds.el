(set-register ?e `(file . ,(locate-user-emacs-file "init.el")))

(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-set-key (kbd "<M-up>") 'scroll-up-line)
(global-set-key (kbd "<M-down>") 'scroll-down-line)

(put 'overwrite-mode 'disabled "Overwrite mode is disabled becuase it's crap.")
(global-set-key [remap overwrite-mode] 'ignore)

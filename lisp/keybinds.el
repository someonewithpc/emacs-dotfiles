(set-register ?e `(file . ,(locate-user-emacs-file "init.el")))

(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(put 'overwrite-mode 'disabled "Overwrite mode is disabled becuase it's crap.")
(global-set-key [remap overwrite-mode] 'ignore)

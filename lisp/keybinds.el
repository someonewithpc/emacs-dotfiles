(set-register ?e `(file . ,(locate-user-emacs-file "init.el")))

(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-set-key (kbd "<M-up>") 'scroll-up-line)
(global-set-key (kbd "<M-down>") 'scroll-down-line)

(put 'overwrite-mode 'disabled "Overwrite mode is disabled becuase it's crap.")
(global-set-key [remap overwrite-mode] 'ignore)

(defun move-beginning-of-line-logical ()
  (interactive)
  (if (not (bolp))
      (move-beginning-of-line nil)
    (back-to-indentation)))

(defun move-end-of-line-logical ()
  (interactive)
  (if (not (eolp))
      (move-end-of-line nil)
    (let ((comment-pos (save-excursion
                         (move-end-of-line nil)
                         (comment-search-backward (line-beginning-position) t)))) ;; adasd
      (if comment-pos
          (goto-char (1- comment-pos))
        (move-end-of-line nil)))))

(global-set-key [remap move-beginning-of-line] #'move-beginning-of-line-logical)
(global-set-key [remap move-end-of-line] #'move-end-of-line-logical)

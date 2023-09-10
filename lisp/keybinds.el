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
  "Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line."
  (interactive)
  (let ((initial-pos (point)))
    (back-to-indentation)
    (when (= (point) initial-pos)
      (move-beginning-of-line nil))))

(defun move-end-of-line-logical ()
  "Move point to the end of the line.
If there's a comment, move to the beginning of the comment.
If point is already there, move to the actual end of the line."
  (interactive)
  (let ((initial-pos (point))
        (eol-pos (line-end-position)))
    (if (and comment-start
             (search-backward comment-start (line-beginning-position) t))
        (progn
          (while (and (> (point) (line-beginning-position))
                      (looking-back (regexp-quote comment-start) (line-beginning-position)))
            (backward-char))
          (skip-syntax-backward " "))
      (goto-char eol-pos))))

(global-set-key [remap move-beginning-of-line] #'move-beginning-of-line-logical)
(global-set-key [remap move-end-of-line] #'move-end-of-line-logical)

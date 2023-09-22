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
  (let* ((initial (point))
        (bol (line-beginning-position))
        (eol (line-end-position))
        (after-comment (search-backward comment-start bol t)))

    (defun move (invert)
      (if after-comment
          (if invert
              (progn (goto-char after-comment) (backward-char) (skip-syntax-backward " "))
            (progn
              (goto-char eol)
              (skip-syntax-backward " "))
            )
        (if (not invert)
            (progn
              (goto-char bol)
              (when (search-forward comment-start eol 1)
                (progn (backward-char) (skip-syntax-backward " "))))
          (progn (goto-char eol) (skip-syntax-backward " "))))
      (point))

    (when (= initial (move nil))
      (move t))
    ))

(global-set-key [remap move-beginning-of-line] #'move-beginning-of-line-logical)
(global-set-key [remap move-end-of-line] #'move-end-of-line-logical)

;; Reload Emacs
(setq desktop-dirname (expand-file-name "local/desktop/" user-emacs-directory))
(unless (file-exists-p desktop-dirname)
    (make-directory desktop-dirname t))

(require 'desktop)
(if (file-exists-p (desktop-full-file-name))
    (progn
      (desktop-save-mode t)
      (add-hook 'desktop-after-read-hook
                (lambda ()
                  "Delete the current desktop file."
                  (when desktop-dirname
                    (let ((desktop-file (desktop-full-file-name)))
                      (when (file-exists-p desktop-file)
                        (delete-file desktop-file))))
                  (desktop-save-mode -1))
      )))

(defun reload-emacs ()
  "Save the desktop and then restart Emacs using `restart-emacs`."
  (interactive)
  ;; Save the current desktop
  (desktop-save desktop-dirname)
  ;; Use the restart-emacs function to restart Emacs
  (restart-emacs))

(global-set-key (kbd "C-c r") 'reload-emacs)

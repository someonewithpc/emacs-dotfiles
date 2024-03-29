
(when (not (display-graphic-p))
  ;; I'm not sure why, but when running in a terminal other than in a TTY, for some reason, the arrow keys don't work
  (progn
    (defvar arrow-keys-map (make-sparse-keymap) "Keymap for arrow keys")
    (define-key esc-map "O" arrow-keys-map)
    (define-key arrow-keys-map "A" 'previous-line)
    (define-key arrow-keys-map "B" 'next-line)
    (define-key arrow-keys-map "C" 'forward-char)
    (define-key arrow-keys-map "D" 'backward-char))
  (xterm-mouse-mode)
  (setq frame-resize-pixelwise t)
  )

(when (display-graphic-p)
  (unbind-key (kbd "C-z")) ;; Disable suspend-frame in graphical mode. Still useful in terminal mode, though
  )

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(defun kill-term-hook ()
  "A term hook to kill the buffer when the process exits."
  (let* ((buff (current-buffer))
         (proc (get-buffer-process buff)))
    (set-process-sentinel
     proc
     `(lambda (process event)
        (if (string= event "finished\n")
            (kill-buffer ,buff))))))

(eval-after-load 'term (add-hook 'term-exec-hook 'kill-term-hook))

(use-package term
  :defer 1
  :bind (:map term-raw-map ("C-S-v" . term-paste))
  :config (progn (term-pager-enable)
		 (add-hook 'term-exec-hook 'kill-term-hook)
		 (setq explicit-shell-file-name "/bin/bash")
		 ;;(setq )
		 )
  ;;(setq explicit-shell-file-name "/bin/bash")
  )

;; (use-package multi-term
;;   ;; :config (setq multi-term-program "/bin/bash")
;;   )

(provide 'setup-terminal)

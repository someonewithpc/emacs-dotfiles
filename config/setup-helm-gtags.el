
;;; Commentary:
;; this variables must be set before load helm-gtags
;; you can change to any prefix key of your choice


;;; Code:

(use-package ggtags
  :defer 5
  :config (setq ggtags-global-ignore-case nil)
  :hook ((c-mode c++-mode java-mode asm-mode php-mode dired-mode) . ggtags-mode) ;; In these modes, start ggtags
  :bind (:map ggtags-mode-map
              ("C-c g s" . ggtags-find-other-symbol)
              ("C-c g h" . ggtags-view-tag-history)
              ("C-c g r" . ggtags-find-reference)
              ("C-c g f" . ggtags-find-file)
              ("C-c g c" . ggtags-create-tags)
              ("C-c g u" . ggtags-update-tags)
              ("M-."     . ggtags-find-tag-dwim)
              ("M-,"     . pop-tag-mark)
              ("C-c <"   . ggtags-prev-mark)
              ("C-c >"   . ggtags-next-mark)
              ;; Why would it override these!?
              ("M-<"     . beginning-of-buffer)
              ("M->"     . end-of-buffer)))

(use-package helm-gtags
  :defer 5
  :after (ggtags helm)
  :config (setq helm-gtags-ignore-case nil
                ;; helm-gtags-auto-update t
                helm-gtags-use-input-at-cursor t
                helm-gtags-pulse-at-cursor t
                ;; helm-gtags-prefix-key "\C-cg"
                ;; helm-gtags-suggested-key-mapping t
                )
  :hook ((;; Enable helm-gtags-mode in Dired so you can jump to any tag
          ;; when navigating the project tree with Dired
          dired-mode
          ;; Enable helm-gtags-mode in Eshell for the same reason as above
          eshell-mode
          ;; Enable helm-gtags-mode in languages that GNU Global supports
          c-mode
          c++-mode
          java-mode
          asm-mode
          php-mode)
         . helm-gtags-mode)
  :bind (:map helm-gtags-mode-map
              ("C-c g a" . helm-gtags-tags-in-this-function)
              ("M-."     . helm-gtags-dwim)
              ("M-,"     . helm-gtags-pop-stack)
              ("C-c g a" . helm-gtags-tags-in-this-function)
              ("C-c <"   . helm-gtags-previous-history)
              ("C-c >"   . helm-gtags-next-history)))
              ;;("C-S-j"   . helm-gtags-select)
              ;;("M-,"     . helm-gtags-select)

(provide 'setup-helm-gtags)
;;; setup-helm-gtags.el ends here

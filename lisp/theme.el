(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-material-dark t)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

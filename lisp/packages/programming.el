(use-package highlight-indent-guides
  :defer 1
  :hook (prog-mode . highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method (if (display-graphic-p) 'bitmap 'character)
                highlight-indent-guides-auto-odd-face-perc 100
                highlight-indent-guides-auto-even-face-perc 100
                highlight-indent-guides-auto-character-face-perc 100
                highlight-indent-guides-bitmap-function #'highlight-indent-guides--bitmap-line
                )
  )

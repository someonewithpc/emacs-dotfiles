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

(use-package treesit
  :straight nil
  :config
  (setq treesit-language-source-alist
        '((bash "https://github.com/tree-sitter/tree-sitter-bash")
          (cmake "https://github.com/uyha/tree-sitter-cmake")
          (make "https://github.com/alemuller/tree-sitter-make")
          (c++ "https://github.com/tree-sitter/tree-sitter-cpp")
          (c "https://github.com/tree-sitter/tree-sitter-c")

          (elisp "https://github.com/Wilfred/tree-sitter-elisp")

          (regex "https://github.com/tree-sitter/tree-sitter-regex")

          (html "https://github.com/tree-sitter/tree-sitter-html")
          (css "https://github.com/tree-sitter/tree-sitter-css")
          (scss "https://github.com/serenadeai/tree-sitter-scss")
          (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
          (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")

          (json "https://github.com/tree-sitter/tree-sitter-json")

          (ruby "https://github.com/tree-sitter/tree-sitter-ruby")
          (embedded-template "https://github.com/tree-sitter/tree-sitter-embedded-template")

          (python "https://github.com/tree-sitter/tree-sitter-python")

          (toml "https://github.com/tree-sitter/tree-sitter-toml")
          (yaml "https://github.com/ikatyang/tree-sitter-yaml")

          (markdown "https://github.com/ikatyang/tree-sitter-markdown")

          (go "https://github.com/tree-sitter/tree-sitter-go")
          ))

  (setq treesit-load-name-override-list '((c++ "libtree-sitter-c++" "tree_sitter_cpp")))

  (when noninteractive
    (mapc (apply-partially-right #'treesit-install-language-grammar
                                 (expand-file-name "local/tree-sitter-languages/" user-emacs-directory))
          (mapcar #'car treesit-language-source-alist)))

  (setq treesit-extra-load-path `(,(expand-file-name "local/tree-sitter-languages/" user-emacs-directory)))

  (setq major-mode-remap-alist
        (mapcar
         (lambda (sym)
           `(,sym . ,(intern (concat (symbol-name sym) "-ts-mode"))))
         (mapcar #'car treesit-language-source-alist)))
  )

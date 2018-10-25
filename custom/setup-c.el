;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq c-default-style) "java" ;; previously "linux". c-show-syntactic-information is useful

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; DON'T use space to indent by default
(setq-default indent-tabs-mode t)
;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 8)

;; setup GDB
(setq gdb-many-windows t ;; use gdb-many-windows by default
      gdb-show-main t ;; Non-nil means display source file containing the main routine at startup
 )

(use-package cc-mode
  ;; :init
  ;; (define-key c-mode-map  [(tab)] 'company-complete)
  ;; (define-key c++-mode-map  [(tab)] 'company-complete)
  )

;; company
(use-package company
  :requires cc-mode
  :init
  (global-company-mode 1)
  :bind (:map c-mode-map ([C-tab] . 'company-complete)
	 :map c++-mode-map ([C-tab] . 'company-complete))
  ;; (delete 'company-semantic company-backends)
  )

;; (define-key c-mode-map  [(control tab)] 'company-complete)
;; (define-key c++-mode-map  [(control tab)] 'company-complete)

(use-package helm-company
  :requires 'company
  :bind (:map company-mode-map ("C-:" . 'helm-company)
	      :map company-active-map ("C-:" . 'helm-company))
  )

;; Package: projectile
(use-package projectile
  :init
  (projectile-global-mode)
  (setq projectile-enable-caching t))

;; ;; Compilation
;; (global-set-key (kbd "<f5>") (lambda ()
;;                                (interactive)
;;                                (setq-local compilation-read-command nil)
;;                                (call-interactively 'compile)))

;; company-c-headers
(use-package company-c-headers
  :init
  (add-to-list 'company-backends 'company-c-headers))

;; hs-minor-mode for folding source code
;; (add-hook 'c-mode-common-hook 'hs-minor-mode)
;; Use origami instead
(use-package origami
  :hook c-mode-hook
  :bind (:map origami-mode-map
              ("C-c o S" . origami-show-node)
              ("C-c o H" . origami-close-node)
              )
  )

(provide 'setup-c)

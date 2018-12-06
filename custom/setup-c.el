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
;;; Code:

;; (setq 'c-default-style ('(c-mode . "java")
;; 			'(c++-mode . "java")
;; 			'(java-mode . "java")
;; 			'(awk-mode . "awk")
;; 			'(other . "gnu"))) "java" ;; previously "linux". c-show-syntactic-information is useful

;; setup GDB
(setq gdb-many-windows t ;; use gdb-many-windows by default
      gdb-show-main t ;; Non-nil means display source file containing the main routine at startup
 )

(use-package cc-mode
  ;; :init (setq c-basic-offset 8)
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
  (projectile-mode)
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

;; (defun my-c-mode-common-hook ()
;;   ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
;;   ;; (c-set-offset 'substatement-open 0)
;;   ;; other customizations can go here

;;   (setq c++-tab-always-indent t)
;;   (setq c-basic-offset 8)                  ;; Default is 2
;;   (setq c-indent-level 8)                  ;; Default is 2

;;   ;;(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
;;   (setq tab-width 8)
;;   (setq indent-tabs-mode t)  ; use spaces only if nil
;;   )

;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;(setq c-basic-offset 8)

(use-package semantic
  :config (progn (global-semanticdb-minor-mode 1)
	       (global-semantic-idle-scheduler-mode 1)
	       (global-semantic-stickyfunc-mode 1)
	       (semantic-mode 1))
  )

;; (use-package function-args
;;   :config
;;   (fa-config-default)
;;   (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;;   (set-default 'semantic-case-fold t)
;;   )

(use-package company-irony
  :ensure t
  :config
  (add-to-list 'company-backends 'company-irony))
(use-package company-irony-c-headers
  :ensure t
  :config
  (add-to-list 'company-backends 'company-irony-c-headers))

(use-package irony
  :after (company-irony company-irony-c-headers)
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  ;; replace the `completion-at-point' and `complete-symbol' bindings in
  ;; irony-mode's buffers by irony-mode's function
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; (use-package semantic-bovine)

(use-package cmake-ide
  :ensure t
  :init
  ;; (setq cmake-ide-flags-c++ (append '("-std=c++11")
  ;; 				    (mapcar (lambda (path) (concat "-I" path))
  ;; 					    ;; (semantic-gcc-get-include-paths "c++")
  ;; 					    )))
  ;; (setq cmake-ide-flags-c (append (mapcar (lambda (path) (concat "-I" path))
  ;; 					  ;; (semantic-gcc-get-include-paths "c")
  ;; 					  )))
  (cmake-ide-setup))

(use-package ede
  :requires cc-mode
  :init (global-ede-mode)
  :hook (c-mode-common-hook c-mode-hook c++-mode-hook)
  :bind (:map c-mode-base-map ("C-c C-j" . semantic-ia-fast-jump)
              ("C-c C-s" . semantic-ia-show-summary))
  )

(add-hook 'prog-mode-hook
          (lambda () (interactive)
	    ;; show unncessary whitespace that can mess up your diff
            (setq show-trailing-whitespace 1)

	    ;; DON'T use space to indent by default
	    (setq-default indent-tabs-mode t)
	    ;; set appearance of a tab that is represented by 4 spaces
	    (setq-default tab-width 8)

	    (setq-default c-basic-offset 8)
	    (c-set-offset 'inextern-lang 0)
	    ))

(provide 'setup-c)

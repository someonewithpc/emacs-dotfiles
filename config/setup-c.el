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

;; Package: projectile
(use-package projectile
  :init
  (projectile-mode)
  (setq projectile-enable-caching t))

;; ;; company - kind of slow. Useful in emacs-lisp, on the fence for others...
;; (use-package company
;;   :requires cc-mode
;;   :hook ((c-mode
;;           c++-mode
;;           emacs-lisp-mode)
;;          . helm-gtags-mode)
;;   :bind (:map c-mode-map ([(control tab)] . 'company-complete)
;;          :map c++-mode-map ([(control tab)] . 'company-complete)
;; 	 :map emacs-lisp-mode-map ([(control tab)] . 'company-complete)))

;; (use-package helm-company
;;   :requires 'company
;;   ;; :bind (:map company-mode-map ("C-:" . 'helm-company)
;;   ;;             :map company-active-map ("C-:" . 'helm-company))
;;   :bind (:map c-mode-map ([(control tab)] . 'helm-company)
;;          :map c++-mode-map ([(control tab)] . 'helm-company)
;; 	 :map emacs-lisp-mode-map ([(control tab)] . 'helm-company)))

;; ;; company-c-headers
;; (use-package company-c-headers
;;   :config
;;   (add-to-list 'company-backends 'company-c-headers))

;; (use-package company-irony
;;   :after (company)
;;   :config
;;   (add-to-list 'company-backends 'company-irony))

;; (use-package company-irony-c-headers
;;   :after (company company-irony)
;;   :config
;;   (add-to-list 'company-backends 'company-irony-c-headers))

(use-package irony
  :after (company-irony company-irony-c-headers)
  :ensure t
  :hook (('c++-mode-hook'c-mode-hook 'emacs-lisp-mode-hook) . 'irony-mode)
  :config
  ;; replace the `completion-at-point' and `complete-symbol' bindings in
  ;; irony-mode's buffers by irony-mode's function
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package semantic
  :config (progn
            (global-semanticdb-minor-mode 1)
            (global-semantic-idle-scheduler-mode 1)
            ;; (global-semantic-stickyfunc-mode 1)
            (semantic-mode 1)))

;; (use-package function-args
;;   :config
;;   (fa-config-default)
;;   (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;;   (set-default 'semantic-case-fold t)
;;   )

;; (use-package semantic-bovine)

;; (use-package cmake-ide
;;   :ensure t
;;   :init
;;   ;; (setq cmake-ide-flags-c++ (append '("-std=c++11")
;;   ;; 				    (mapcar (lambda (path) (concat "-I" path))
;;   ;; 					    ;; (semantic-gcc-get-include-paths "c++")
;;   ;; 					    )))
;;   ;; (setq cmake-ide-flags-c (append (mapcar (lambda (path) (concat "-I" path))
;;   ;; 					  ;; (semantic-gcc-get-include-paths "c")
;;   ;; 					  )))
;;   (cmake-ide-setup))

(use-package ede
  :requires cc-mode
  :init (global-ede-mode)
  :hook (c-mode-common-hook c-mode-hook c++-mode-hook)
  :bind (:map c-mode-base-map ("C-c C-j" . semantic-ia-fast-jump)
              ("C-c C-s" . semantic-ia-show-summary))
  )

(define-key c-mode-map (kbd "C-c C-d") nil)
(define-key c++-mode-map (kbd "C-c C-d") nil)

(add-hook 'prog-mode-hook
          (lambda () (interactive)
	    ;; show unncessary whitespace that can mess up your diff
            (setq show-trailing-whitespace 1)

	    ;; DON'T use space to indent by default
	    (setq-default indent-tabs-mode nil)
	    ;; set appearance of a tab that is represented by 4 spaces
	    (setq-default tab-width 4)

	    (setq-default c-basic-offset 4)
	    (c-set-offset 'inextern-lang 0)
        (global-set-key (kbd "C-c C-d") 'duplicate-thing)
	    ))

(use-package cmake-mode)

(provide 'setup-c)

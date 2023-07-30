;;; defaults.el --- Set default values for a variety of variables, to tweak performance -*- lexical-binding: t; -*-

;;; Adapted from Doom Emacs (MIT license)

;; PERF: A second, case-insensitive pass over `auto-mode-alist' is time wasted.
(setq auto-mode-case-fold nil)

;; PERF: Disable bidirectional text scanning for a modest performance boost.
;;   I've set this to `nil' in the past, but the `bidi-display-reordering's docs
;;   say that is an undefined state and suggest this to be just as good:
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)

;; PERF: Disabling BPA makes redisplay faster, but might produce incorrect
;;   reordering of bidirectional text with embedded parentheses (and other
;;   bracket characters whose 'paired-bracket' Unicode property is non-nil).
(setq bidi-inhibit-bpa t)  ; Emacs 27+ only

;; ;; Reduce rendering/line scan work for Emacs by not rendering cursors or regions
;; ;; in non-focused windows.
;; (setq-default cursor-in-non-selected-windows nil)
;; (setq highlight-nonselected-windows nil)

;; More performant rapid scrolling over unfontified regions. May cause brief
;; spells of inaccurate syntax highlighting right after scrolling, which should
;; quickly self-correct.
(setq fast-but-imprecise-scrolling t)

;; Command find-file-at-point replaces find-file
;; Don't ping things that look like domain names.
(setq ffap-machine-p-known 'reject)

;; PGTK builds only: this timeout adds latency to frame operations, like
;; `make-frame-invisible', which are frequently called without a guard because
;; it's inexpensive in non-PGTK builds. Lowering the timeout from the default
;; 0.1 should make childframes and packages that manipulate them (like `lsp-ui',
;; `company-box', and `posframe') feel much snappier. See emacs-lsp/lsp-ui#613.
(eval-when! (boundp 'pgtk-wait-for-event-timeout)
  (setq pgtk-wait-for-event-timeout 0.001))

;; Increase how much is read from processes in a single chunk (default is 4kb).
;; This is further increased elsewhere, where needed (like our LSP module).
(setq read-process-output-max (* 64 1024))  ; 64kb

;; Introduced in Emacs HEAD (b2f8c9f), this inhibits fontification while
;; receiving input, which should help a little with scrolling performance.
(setq redisplay-skip-fontification-on-input t)

;;; Disable UI elements early
;; PERF,UI: Doom strives to be keyboard-centric, so I consider these UI elements
;;   clutter. Initializing them also costs a morsel of startup time. Whats more,
;;   the menu bar exposes functionality that Doom doesn't endorse. Perhaps one
;;   day Doom will support these, but today is not that day.
;;
;; HACK: I intentionally avoid calling `menu-bar-mode', `tool-bar-mode', and
;;   `scroll-bar-mode' because they do extra work to manipulate frame variables
;;   that isn't necessary this early in the startup process.
(push '(menu-bar-lines . 0)   default-frame-alist)
(push '(tool-bar-lines . 0)   default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
;; And set these to nil so users don't have to toggle the modes twice to
;; reactivate them.
(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil)
(advice-add #'tool-bar-setup :override #'ignore)
;; (add-hook 'emacs-startup-hook #'scroll-bar-mode)

;; PERF: Resizing the Emacs frame (to accommodate fonts that are smaller or
;;   larger than the system font) appears to impact startup time
;;   dramatically. The larger the delta in font size, the greater the delay.
;;   Even trivial deltas can yield a ~1000ms loss, though it varies wildly
;;   depending on font size.
(setq frame-inhibit-implied-resize t)

;; PERF,UX: Reduce *Message* noise at startup. An empty scratch buffer (or
;;   the dashboard) is more than enough, and faster to display.
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name)

;; PERF,UX: Remove "For information about GNU Emacs..." message at startup.
;;   It's redundant with our dashboard and incurs a premature redraw.
(advice-add #'display-startup-echo-area-message :override #'ignore)

;; PERF: Suppress the vanilla startup screen completely. We've disabled it
;;   with `inhibit-startup-screen', but it would still initialize anyway.
;;   This involves some file IO and/or bitmap work (depending on the frame
;;   type) that we can no-op for a free 50-100ms boost in startup time.
(advice-add #'display-startup-screen :override #'ignore)

;; PERF: Shave seconds off startup time by starting the scratch buffer in
;;   `fundamental-mode', rather than, say, `org-mode' or `text-mode', which
;;   pull in a ton of packages. `doom/open-scratch-buffer' provides a better
;;   scratch buffer anyway.
(setq initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

(unless initial-window-system
  ;; PERF: Inexplicably, `tty-run-terminal-initialization' can sometimes
  ;;   take 2-3s when starting up Emacs in the terminal. Whatever slows it
  ;;   down at startup doesn't appear to affect it if it's called a little
  ;;   later in the startup process, so that's what I do.
  ;; REVIEW: This optimization is not well understood. Investigate it!
  (define-advice tty-run-terminal-initialization (:override (&rest _) defer)
    (advice-remove #'tty-run-terminal-initialization #'tty-run-terminal-initialization@defer)
    (add-hook 'window-setup-hook
              (apply-partially #'tty-run-terminal-initialization (selected-frame) nil t))))

(unless init-file-debug
  ;; PERF,UX: Site files tend to use `load-file', which emits "Loading X..."
  ;;   messages in the echo area. Writing to the echo-area triggers a
  ;;   redisplay, which can be expensive during startup. This may also cause
  ;;   an flash of white when creating the first frame.
  (define-advice load-file (:override (file) silence)
    (load file nil 'nomessage))
  ;; COMPAT: But undo our `load-file' advice later, as to limit the scope of
  ;;   any edge cases it could induce.
  (add-hook 'after-init-hook (lambda () (advice-remove #'load-file #'load-file@silence))))

;; PERF: `load-suffixes' and `load-file-rep-suffixes' are consulted on each `require' and `load'
(put 'load-suffixes 'initial-value (default-toplevel-value 'load-suffixes))
(put 'load-file-rep-suffixes 'initial-value (default-toplevel-value 'load-file-rep-suffixes))
(set-default-toplevel-value 'load-suffixes '(".eln" ".elc" ".el"))
(set-default-toplevel-value 'load-file-rep-suffixes '(""))
;; COMPAT: Undo any problematic startup optimizations; from this point, I make
;;   no assumptions about what might be loaded in userland.
(add-hook 'after-init-hook
          (lambda ()
            (setq load-suffixes (get 'load-suffixes 'initial-value)
                  load-file-rep-suffixes (get 'load-file-rep-suffixes 'initial-value))))

;; PERF: The mode-line procs a couple dozen times during startup. This is
;;   normally quite fast, but disabling the default mode-line and reducing the
;;   update delay timer seems to stave off ~30-50ms.
(put 'mode-line-format 'initial-value (default-toplevel-value 'mode-line-format))
(setq-default mode-line-format nil)
(dolist (buf (buffer-list))
  (with-current-buffer buf (setq mode-line-format nil)))
(add-hook 'emacs-startup-hook (lambda () (setq-default mode-line-format (get 'mode-line-format 'initial-value))))


;; PERF,UX: Premature redisplays can substantially affect startup times and
;;   produce ugly flashes of unstyled Emacs.
(setq-default inhibit-redisplay t
              inhibit-message t)
(add-hook 'after-init-hook
          (lambda ()
            (setq-default inhibit-redisplay nil
                          ;; Inhibiting `message' only prevents redraws and
                          inhibit-message nil)
            (redraw-frame)))


;; Allow the user to store custom.el-saved settings and themes in their Doom
;; config (e.g. ~/.doom.d/).
(setq custom-file (locate-user-emacs-file "custom.el"))
(define-advice en/disable-command (:around (fn &rest args) write-to-custom-file)
  "Save safe-local-variables to `custom-file' instead of `user-init-file'.

Otherwise, `en/disable-command' (in novice.el.gz) is hardcoded to write them to
`user-init-file')."
  (let ((user-init-file custom-file))
    (apply fn args)))

;; By default, Emacs stores `authinfo' in $HOME and in plain-text. Let's not do
;; that, mkay? This file stores usernames, passwords, and other treasures for
;; the aspiring malicious third party. You'll need a GPG setup though.
(setq auth-sources '("~/.authinfo.gpg"))


;;; Native compilation support (see http://akrl.sdf.org/gccemacs.html)
(when (boundp 'native-comp-eln-load-path)
  ;; UX: Suppress compiler warnings and don't inundate users with their popups.
  ;;   They are rarely more than warnings, so are safe to ignore.
  (setq native-comp-async-report-warnings-errors init-file-debug
        native-comp-warning-on-missing-source init-file-debug))

;; HACK: native-comp-deferred-compilation-deny-list is replaced in later
;;   versions of Emacs 29, and with no deprecation warning. I alias them to
;;   ensure backwards compatibility for packages downstream that may have not
;;   caught up yet. I avoid marking it obsolete because obsolete warnings are
;;   unimportant to end-users. It's the package devs that should be informed.
(unless (boundp 'native-comp-deferred-compilation-deny-list)
  (defvaralias 'native-comp-deferred-compilation-deny-list 'native-comp-jit-compilation-deny-list))

;;; Suppress package.el
;; Since Emacs 27, package initialization occurs before `user-init-file' is
;; loaded, but after `early-init-file'. Doom handles package initialization, so
;; we must prevent Emacs from doing it again.
(setq package-enable-at-startup nil)

;;; Reduce unnecessary/unactionable warnings/logs
;; Disable warnings from the legacy advice API. They aren't actionable or
;; useful, and often come from third party packages.
(setq ad-redefinition-action 'accept)

;; Ignore warnings about "existing variables being aliased". Otherwise the user
;; gets very intrusive popup warnings about our (intentional) uses of
;; defvaralias, which are done because ensuring aliases are created before
;; packages are loaded is an unneeded and unhelpful maintenance burden. Emacs
;; still aliases them fine regardless.
(setq warning-suppress-types '((defvaralias)))

;; Reduce debug output unless we've asked for it.
(setq debug-on-error init-file-debug
      jka-compr-verbose init-file-debug)

;;; Encodings
;; Contrary to what many Emacs users have in their configs, you don't need more
;; than this to make UTF-8 the default coding system:
(set-language-environment "UTF-8")
;; ...but `set-language-environment' also sets `default-input-method', which is
;; a step too opinionated.
(setq default-input-method nil)
(setq selection-coding-system 'utf-8)

;;; Stricter security defaults
;; Emacs is essentially one huge security vulnerability, what with all the
;; dependencies it pulls in from all corners of the globe. Let's try to be a
;; *little* more discerning.
(setq gnutls-verify-error noninteractive
      gnutls-algorithm-priority
      (when (boundp 'libgnutls-version)
        (concat "SECURE128:+SECURE192:-VERS-ALL"
                (if (>= libgnutls-version 30605)
                    ":+VERS-TLS1.3")
                ":+VERS-TLS1.2"))
      ;; `gnutls-min-prime-bits' is set based on recommendations from
      ;; https://www.keylength.com/en/4/
      gnutls-min-prime-bits 3072
      tls-checktrust gnutls-verify-error
      ;; Emacs is built with gnutls.el by default, so `tls-program' won't
      ;; typically be used, but in the odd case that it does, we ensure a more
      ;; secure default for it (falling back to `openssl' if absolutely
      ;; necessary). See https://redd.it/8sykl1 for details.
      tls-program '("openssl s_client -connect %h:%p -CAfile %t -nbio -no_ssl3 -no_tls1 -no_tls1_1 -ign_eof"
                    "gnutls-cli -p %p --dh-bits=3072 --ocsp --x509cafile=%t \
--strict-tofu --priority='SECURE192:+SECURE128:-VERS-ALL:+VERS-TLS1.2:+VERS-TLS1.3' %h"
                    ;; compatibility fallbacks
                    "gnutls-cli -p %p %h"))

;; Remember these variables' initial values, so we can safely reset them at
;; a later time, or consult them without fear of contamination.
(dolist (var '(exec-path load-path process-environment))
  (put var 'initial-value (default-toplevel-value var)))


;; From Doom Emacs (MIT license)
;; PERF: `file-name-handler-alist' is consulted on each call to `require',
;;   `load', or various file/io functions (like `expand-file-name' or
;;   `file-remote-p'). You get a noteable boost to startup time by unsetting
;;   or simplifying its value.
(let ((old-value (default-toplevel-value 'file-name-handler-alist)))
  (setq file-name-handler-alist
        ;; HACK: If the bundled elisp for this Emacs install isn't
        ;;   byte-compiled (but is compressed), then leave the gzip file
        ;;   handler there so Emacs won't forget how to read read them.
        ;;
        ;;   calc-loaddefs.el is our heuristic for this because it is built-in
        ;;   to all supported versions of Emacs, and calc.el explicitly loads
        ;;   it uncompiled. This ensures that the only other, possible
        ;;   fallback would be calc-loaddefs.el.gz.
        (if (eval-when-compile
              (locate-file-internal "calc-loaddefs.el" load-path))
            nil
          (list (rassq 'jka-compr-handler old-value))))
  ;; Make sure the new value survives any current let-binding.
  (set-default-toplevel-value 'file-name-handler-alist file-name-handler-alist)
  ;; Remember it so it can be reset where needed.
  (put 'file-name-handler-alist 'initial-value old-value)
  ;; COMPAT: ...but restore `file-name-handler-alist' later, because it is
  ;;   needed for handling encrypted or compressed files, among other things.
  (add-hook 'emacs-startup-hook :depth 101
    (lambda () (setq file-name-handler-alist
                     ;; Merge instead of overwrite because there may have been changes to
                     ;; `file-name-handler-alist' since startup we want to preserve.
                     (delete-dups (append file-name-handler-alist old-value))))))


(provide 'defaults)
;;; defaults.el ends here

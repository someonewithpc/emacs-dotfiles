;;; early-init.el Adapted from Doom's early-init
;;;
;;;--- Doom's universal bootstrapper -*- lexical-binding: t -*-
;;
;;; License:
;;
;;  The MIT License (MIT)
;;
;; Copyright (c) 2014-2022 Henrik Lissner.
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
;;
;;; Commentary:
;;
;; This file, in summary:
;; - Determines where `user-emacs-directory' is by:
;;   - Processing `--init-directory DIR' (backported from Emacs 29),
;;   - Processing `--profile NAME' (see
;;     `https://docs.doomemacs.org/-/developers' or docs/developers.org),
;;   - Or assume that it's the directory this file lives in.
;; - Loads Doom as efficiently as possible, with only the essential startup
;;   optimizations, and prepares it for interactive or non-interactive sessions.
;; - If Doom isn't present, then we assume that Doom is being used as a
;;   bootloader and the user wants to load a non-Doom config, so we undo all our
;;   global side-effects, load `user-emacs-directory'/early-init.el, and carry
;;   on as normal (without Doom).
;; - Do all this without breaking compatibility with Chemacs.
;;
;; early-init.el was introduced in Emacs 27.1. It is loaded before init.el,
;; before Emacs initializes its UI or package.el, and before site files are
;; loaded. This is great place for startup optimizing, because only here can you
;; *prevent* things from loading, rather than turn them off after-the-fact.
;;
;; Doom uses this file as its "universal bootstrapper" for both interactive and
;; non-interactive sessions. That means: no matter what environment you want
;; Doom in, load this file first.
;;
;;; Code:

;; PERF: Garbage collection is a big contributor to startup times. This fends it
;;   off, but will be reset later by `gcmh-mode'. Not resetting it later will
;;   cause stuttering/freezes.
(setq gc-cons-threshold most-positive-fixnum)

;; UX: Set a dark color as soon as possible to reduce flashing
(setq default-frame-alist '((background-color . "black") (foreground-color . "white")))

(when noninteractive
  (setq user-emacs-directory (file-name-directory load-file-name)))

(startup-redirect-eln-cache (locate-user-emacs-file "local/eln-cache"))

;; PERF: Don't use precious startup time checking mtime on elisp bytecode.
;;   Ensuring correctness is 'doom sync's job, not the interactive session's.
;;   Still, stale byte-code will cause *heavy* losses in startup efficiency.
(setq load-prefer-newer noninteractive)

;; Prevemt package.el from doing anything, since we'll use straight.el
(setq package-enable-at-startup nil)

;; UX: Respect DEBUG envvar as an alternative to --debug-init, and to make are
;;   startup sufficiently verbose from this point on.
(when (getenv-internal "DEBUG")
  (setq init-file-debug t
        debug-on-error t))

;; PERF: `file-name-handler-alist' is consulted often. Unsetting it offers a
;;   notable saving in startup time. This let-binding is just a stopgap though,
;;   a more complete version of this optimization can be found in lisp/doom.el.
(setq file-name-handler-alist nil)

;; PERF: When `load'ing or `require'ing files, each permutation of
;;   `load-suffixes' and `load-file-rep-suffixes' (then `load-suffixes' +
;;   `load-file-rep-suffixes') is used to locate the file.  Each permutation
;;   is a file op, which is normally very fast, but they can add up over the
;;   hundreds/thousands of files Emacs needs to load.
;;
;;   To reduce that burden -- and since Doom doesn't load any dynamic modules
;;   -- I remove `.so' from `load-suffixes' and pass the `must-suffix' arg to
;;   `load'. See the docs of `load' for details.
(setq load-suffixes '(".eln" ".elc" ".el"))
(add-hook 'emacs-startup-hook (lambda () (setq load-suffixes (default-toplevel-value 'load-suffixes))))

(let ((eln-cache-dir (concat (file-name-as-directory user-emacs-directory) "local/eln-cache")))
  (when (file-directory-p eln-cache-dir)
    (add-to-list 'load-path (car (directory-files eln-cache-dir t "^[^.]")))))

(when noninteractive (load (expand-file-name "init" user-emacs-directory) nil (not init-file-debug) nil 'must-suffix))

;;(let ((load-suffixes '(".eln" ".elc" ".el")))
;;  (load (expand-file-name "init" user-emacs-directory) nil (not init-file-debug) nil 'must-suffix))

;;; early-init.el ends here

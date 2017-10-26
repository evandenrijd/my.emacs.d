;;; init --- start of everything
;;; Commentary:
;;; Code:

(package-initialize)

;; Are we on a mac?
(defvar is-mac (equal system-type 'darwin))

;; Set path to dependencies
(defvar site-lisp-dir
  (expand-file-name "site-lisp" user-emacs-directory))
(defvar settings-dir
  (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path settings-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Settings for currently logged in user
(setq user-settings-dir
      (concat user-emacs-directory "users/" user-login-name))
(add-to-list 'load-path user-settings-dir)

;; bootstrap use-package
(require 'setup-package)

;; Make zooming affect frame instead of buffers
(use-package zoom-frm
  :demand ;; force loading before appearance
  :bind (("s-+" . zoom-in)
         ("s--" . zoom-out)))

(use-package appearance
  :demand) ;; Set up appearance early

(use-package better-defaults
  :ensure t)

(use-package magit
  :ensure t
  :bind (("C-x m" . magit-status-fullscreen))
  :config (require 'setup-magit))

(use-package smartparens
  :ensure t
  :config (require 'setup-smartparens))

(use-package undo-tree
  :ensure t)

(if is-mac
    (use-package exec-path-from-shell
      :ensure t
      :config (exec-path-from-shell-initialize)))

(use-package json-mode
  :ensure t)

(use-package yaml-mode
  :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.\\(yml\\|yaml\\)\\'" . yaml-mode)))

(use-package rpm-spec-mode
  :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.spec\\'" . rpm-spec-mode)))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package angular-mode
  :ensure t)

(use-package flycheck
  :ensure t
  :config (setq-default flycheck-disabled-checkers
                        (append flycheck-disabled-checkers '(emacs-lisp-checkdoc)))
  :init (global-flycheck-mode))

(use-package mac-speak
  :if is-mac
  :load-path "site-lisp/"
  :bind (("C-x s" . mac-speak)))

(use-package osx-dictionary
  :if is-mac
  :ensure t
  :bind (("s-d" . osx-dictionary-search-word-at-point)
         ("s-i" . osx-dictionary-search-input)))

;; Lets start with a smattering of sanity
(require 'sane-defaults)

;; set ido-mode everywhere and +
(use-package ido-ubiquitous
  :ensure t
  :init (ido-mode 1) (ido-everywhere t)
  ;; Ignore .DS_Store files with ido mode
  (if is-mac (add-to-list 'ido-ignore-files "\\.DS_Store"))
  :config (ido-ubiquitous-mode 1)
)

(use-package find-file-in-project
  :ensure t
  ;; :config (require 'setup-ffip)

  ;;(remark that: C-x C-s is save-buffer, C-x C-f is find-file and C-x C-d is
  ;;find-dir, the following keys on a qwerty-keyboard are g and h.)
  :bind ("C-x C-g" . find-file-in-project)
  )

(use-package ace-jump-mode
  :ensure t
  :bind ("s-SPC" . ace-jump-mode))

;; Setup key bindings
(require 'key-bindings)

(use-package cperl-mode
  :mode "\\.\\([pP][Llm]\\|al\\|t\\)\\'"
  :interpreter "perl"
  :config (add-hook 'cperl-mode-hook
                    (lambda ()
                      (set (make-local-variable 'compile-command)
                           (format "perl %s" (buffer-file-name)))))
)

(use-package setup-grep-ack  ;; dependency of perl
  :init (setq ack-command "ag --nogroup --nocolor") ;; use ag instead of ack
  )

;; used in elm-mode
(use-package company
  :ensure t)

(use-package elm-mode
  :ensure t
  :config (add-to-list 'company-backends 'company-elm)) ;; MacOS: /Shared/npm_cli $ npm i elm-oracle --save

(use-package setup-mac
  :if is-mac)

(use-package protobuf-mode
  :ensure t
  :config (add-hook 'protobuf-mode-hook
                    (lambda ()
                      (c-add-style "two-spaces-style-no-tabs" ((c-basic-offset . 2)
                                                               (indent-tabs-mode . nil))
                                   t)))
  )

(use-package multiple-cursors
  :ensure t)

;; begin Haskell
(use-package haskell-mode
  :ensure t
  :bind ("C-c h" . haskell-hoogle)
  :init (setq haskell-hoogle-command "hoogle --info ")
  )

(use-package intero
  :ensure t
  :config (intero-global-mode 1) ;; set Intero 'on'
  )
;; Intero key bindings from web:
;; Key binding	Description
;; --------------------------------------------------------------
;; M-.	        Jump to definition
;; C-c C-i	Show information of identifier at point
;; C-c C-t	Show the type of thing at point, or the selection
;; C-u C-c C-t	Insert a type signature for the thing at point
;; C-c C-l	Load this module in the REPL
;; C-c C-c	Evaluate the selected region in the REPL
;; C-c C-r	Apply suggestions from GHC
;; C-c C-k	Clear REPL
;; C-c C-z	Switch to and from the REPL

;; intero-mode minor mode keybindings from Emacs C-h b:
;; Key             binding
;; ---             -------

;; C-c             Prefix Command
;; ESC             Prefix Command

;; M-.             intero-goto-definition
;; M-?             intero-uses-at

;; C-c C-c         intero-repl-eval-region
;; C-c C-e         intero-expand-splice-at-point
;; C-c TAB         intero-info
;; C-c C-l         intero-repl-load
;; C-c C-r         intero-apply-suggestions
;; C-c C-t         intero-type-at
;; C-c C-z         intero-repl
;; end Haskell

(use-package neotree
  :ensure t
  :bind ([f2] . neotree-toggle)
  :init (setq neo-window-width 40)) ;;fixed buffer width

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package org-ref
  :ensure t
  :init (setq reftex-default-bibliography '("/Users/van/vc/docs/orgs/have_copy.bib")))

(require 'setup-tide)

(require 'setup-js2-mode)
;; (use-package company-tern
;;   :ensure t
;;   :config (add-to-list 'company-backends 'company-tern))

(require 'setup-info)

;; Remove all trailing whitespace from every buffer before saving to a file.
(add-hook 'write-file-functions 'delete-trailing-whitespace)

(provide 'init)
;;; init.el ends here

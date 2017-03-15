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

;; Set up appearance early
(require 'appearance)

;; Settings for currently logged in user
(setq user-settings-dir
      (concat user-emacs-directory "users/" user-login-name))
(add-to-list 'load-path user-settings-dir)

;; bootstrap use-package
(require 'setup-package)

(use-package better-defaults
  :ensure t)

;; Remove all trailing whitespace from every buffer before saving to a file.
(add-hook 'write-file-functions 'delete-trailing-whitespace)

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

(use-package flycheck
  :ensure t
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

;; Setup key bindings
(require 'key-bindings)

(require 'setup-perl)
(require 'setup-grep-ack)
(if is-mac (require 'setup-mac))
(require 'setup-js2-mode)

(require 'setup-info)

(provide 'init)
;;; init.el ends here

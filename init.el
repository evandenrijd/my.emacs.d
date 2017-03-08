(package-initialize)

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))
(setq settings-dir
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

;; Setup packages
(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(better-defaults
     magit
     use-package
     smartparens
     undo-tree
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(defun init--macos-install-packages ()
  (packages-install
   '(osx-dictionary
     )))

(if is-mac (condition-case nil
    (init--macos-install-packages)
  (error
   (package-refresh-contents)
   (init--macos-install-packages))))

;; Lets start with a smattering of sanity
(require 'sane-defaults)

;; Setup key bindings
(require 'key-bindings)

(eval-after-load 'magit '(require 'setup-magit))
(require 'setup-smartparens)
(require 'setup-perl)
(require 'setup-grep-ack)
(if is-mac (require 'setup-mac))

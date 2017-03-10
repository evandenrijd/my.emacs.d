;;; setup-package --- bootstrap use-package
;;; Commentary:
;;;   The package use-package is used to install all packages nice and tidy.
;;;   We bootstrap use-package, this is the first package installed into a fresh
;;;     Emacs.
;;; Code:

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

;; Bootstrap `use-package'
;; rest of the package installation should be done with use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(provide 'setup-package)
;;; setup-package.el ends here

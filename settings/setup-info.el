;;; setup-info --- copy info manuals for reading
;;; Commentary:
;;;   start with GNU make
;;; Code:
(defvar info-dir (expand-file-name "info" user-emacs-directory)
  "Directory where info-files are placed.")
(add-to-list 'Info-directory-list info-dir)

;; untar the make.info.tar.gz
;; + install-info --info-dir . make.info

(provide 'setup-info)
;;; setup-info.el ends here

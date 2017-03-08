;; (defvar mac-speak-mode-p nil
;;   "Mode variable for the MacSpeak minor mode.")
;; (make-variable-buffer-local 'mac-speak-mode-p)

;; (defun mac-speak-mode (&optional arg)
;;   "Mac-Speak minor mode.
;;    Special commands:
;;     \\{mac-speak-mode-map}"
;;   (interactive "P")
;;   (setq mac-speak-mode-p
;;         (if (null arg)
;;             (not mac-speak-mode-p)
;;           (> (prefix-numeric-value arg) 0)))
;;   (if mac-speak-mode-p
;;       (use-local-map mac-speak-mode-map)      ;this installs the keymap
;;     (use-local-map nil)
;;   )
;; )

(defcustom mac-say-executable "/usr/bin/say"
  "Is the executable that says something."
  :type 'string
  :group 'customize
  )

;;The short string describing this minor mode that appear in the mode portion of
;;the mode line.
;; (if (not (assq 'mac-speak-mode minor-mode-alist))
;;     (setq minor-mode-alist
;;           (cons '(mac-speak-mode " MacSpeak")
;;                 minor-mode-alist)))

;; (defvar mac-speak-mode-map nil
;;   "Keymap for mac-speak minor mode.")
;; (if mac-speak-mode-map
;;     nil
;;   (setq mac-speak-mode-map (make-sparse-keymap))
;;   (define-key mac-speak-mode-map  "\C-xs"  'mac-speak)
;;   (message "MacSpeak set")
;; )

(defun prep-text (start end)
  "prepare the text before being spoken.
  TBD could replace abbreviation, etc.."
  (buffer-substring start end))

(defun mac-speak ()
  "Speak the current paragraph (starting at cursor until the end)
or the selected region."
  (interactive)
  (if (get-process "mac-speak")
      (if (yes-or-no-p "Currently speaking, remove current?")
          (delete-process "mac-speak"))
    (start-process "mac-speak"
                   nil
                   mac-say-executable
                   (if (region-active-p)
                       (prep-text (region-beginning) (region-end))
                     (prep-text
                      (point)
                      (save-excursion
                        (forward-paragraph)
                        (point)))))
    )
  )

;;(add-hook 'text-mode-hook 'mac-speak-mode)
;;(remove-hook 'text-mode-hook 'mac-speak-mode)

(provide 'mac-speak)

;;Some Perl-like goodies
(defun perl_chomp (str)
  "Chomp tailing whitespace from STR."
  (replace-regexp-in-string (rx (* (any " \t\n")) eos)
                            ""
                            str))

(defun perl_grep (condp list)
  "grep does a filtering on the list"
  (delq nil
        (mapcar (lambda (x) (and (funcall condp x) x)) list)))

(defun perl_join(separator list)
  "Join the list together with a seperator."
  (mapconcat 'identity list separator)
)

;;; Setting the grep-ack command
;; This also works with TRAMP (for this to work you need ack installed on the remote machine)
(defcustom ack-command "ack --nogroup --nocolor" "The ack-command run by the grep-ack function")
(defun grep-ack(directory string options)
  ;;(interactive "DDirectory to search for: \nMString to search for: \nMoptions: ")
  (interactive (list (expand-file-name (read-file-name "Directory to search for: " "." "" t))
                     (read-string "Search for: " (thing-at-point 'symbol))
                     (read-string "Ack arguments: " nil)))
  (let ((default-directory (if (equal (substring directory -1) "/")
                               directory
                             (concat directory "/")))) ;;default-directory always need to end with a slash
    (grep-find (perl_join " "
                          (perl_grep (lambda (x) (not (eq nil x)))
                                     (list ack-command options "--match" string ".")))))
)

(provide 'setup-grep-ack)

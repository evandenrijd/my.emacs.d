;;; use a better perl mode
(setq auto-mode-alist
      (cons '("\\.\\([pP][Llm]\\|al\\|t\\)\\'" . cperl-mode)
            auto-mode-alist ) )

(add-hook 'cperl-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "perl %s" (buffer-file-name)))))

;; TODO: remove hardcoded perl-manpath
;; TODO: why is MANPATH not necessary?
;; (setq perl-manpath '("/opt/perl-5.22.0/man"))
;; (setq manpath (eval '(append perl-manpath (getenv "MANPATH"))))
;; (setenv "MANPATH" (eval '(mapconcat 'identity manpath ":")))

(provide 'setup-perl)

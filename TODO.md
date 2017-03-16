TODO

    o perl MANPATH is not correct on MacOS
    ;; TODO: remove hardcoded perl-manpath
    ;; TODO: why is MANPATH not necessary?
    ;; (setq perl-manpath '("/opt/perl-5.22.0/man"))
    ;; (setq manpath (eval '(append perl-manpath (getenv "MANPATH"))))
    ;; (setenv "MANPATH" (eval '(mapconcat 'identity manpath ":")))
    ;; => use exec-path-from-shell for this

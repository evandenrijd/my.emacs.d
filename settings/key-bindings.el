;; Jump to a definition in the current file. (This is awesome)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; Copy file path to kill ring
(global-set-key (kbd "C-x M-w") 'copy-current-file-path)

;; Help should search more than just commands
(global-set-key (kbd "<f1> a") 'apropos)

;; Magit
(global-set-key (kbd "C-x m") 'magit-status-fullscreen)
(autoload 'magit-status-fullscreen "magit")

(global-set-key [M-f6]  'previous-tag)
(global-set-key [C-f6]  'next-tag)
(global-set-key [S-f6]  'second-tag)
(global-set-key [f6]    'find-tag)

(global-set-key [f7]    'copy-buffer-file-name-as-kill)

(defun kill-this-buffer-bis ()
  "replacement of kill-this-buffer, because did nothing on Max OSX"
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key [f8]    'kill-this-buffer-bis)
(global-set-key (kbd "C-x k") 'kill-this-buffer-bis)

(global-set-key [C-f11] 'compile)

(if is-mac (define-key global-map (kbd "s-+") 'zoom-in))
(if is-mac (define-key global-map (kbd "s--") 'zoom-out))

(provide 'key-bindings)

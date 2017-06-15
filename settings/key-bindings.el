;; Jump to a definition in the current file. (This is awesome)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; Copy file path to kill ring
(global-set-key (kbd "C-x M-w") 'copy-current-file-path)

;; Help should search more than just commands
(global-set-key (kbd "<f1> a") 'apropos)

;; standard M-< and M->, added C-< and C->, if we do not have prior and next keys
;; (global-set-key (kbd "M-<") 'beginning-of-buffer)
;; (global-set-key (kbd "M->") 'end-of-buffer)
(global-set-key (kbd "C-<") 'scroll-down-command)
(global-set-key (kbd "C->") 'scroll-up-command)

(global-set-key (kbd "<prior>") 'scroll-down-command)
(global-set-key (kbd "<next>") 'scroll-up-command)
(global-set-key (kbd "<C-prior>") 'beginning-of-buffer)
(global-set-key (kbd "<C-next>") 'end-of-buffer)
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "s-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "s-n") 'forward-paragraph)

;;scrolling one line at the time
(global-set-key (kbd "M-<down>") 'scroll-up-line)
(global-set-key (kbd "M-<up>") 'scroll-down-line)

(global-set-key [M-f6]  'previous-tag)
(global-set-key [C-f6]  'next-tag)
(global-set-key [S-f6]  'second-tag)
(global-set-key [f6]    'find-tag)

(global-set-key [f7]    'copy-buffer-file-name-as-kill)

(defun kill-this-buffer-bis ()
  "Replacement of `kill-this-buffer', because did nothing on MaxOS."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key [f8]    'kill-this-buffer-bis)
(global-set-key (kbd "C-x k") 'kill-this-buffer-bis)

(global-set-key [C-f11] 'compile)
(global-set-key [f12] 'next-error)

(global-set-key (kbd "C-x l") 'goto-line)

(provide 'key-bindings)

;; Keyboard shortcuts	Description
;; M-.	Jump to the definition of the symbol at point. With a prefix arg, Jump to the type definition.
;; M-,	Return to your pre-jump position.

;; M-x tide-restart-server Restart tsserver. This would come in handy after you edit tsconfig.json or checkout a different branch.

;; M-x tide-documentation-at-point Show documentation for the symbol at point.

;; M-x tide-references List all references to the symbol at point in a buffer. References can be navigated using n and p. Press enter to open the file.

;; M-x tide-project-errors List all errors in the project. Errors can be navigated using n and p. Press enter to open the file.

;; M-x tide-rename-symbol Rename all occurrences of the symbol at point.

;; M-x tide-format Format the current region or buffer.

;; M-x tide-fix Apply code fix for the error at point.

;; company, completion framework used by tide and others ...
(use-package company
  :ensure t)

;; tide, typescript ide
(use-package tide
  :ensure t)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(provide 'setup-tide)

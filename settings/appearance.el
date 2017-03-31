;; essentially set the font-size
(setq van/default-font "-*-*-*-*-*-*-20-*-*-*-m-0-iso10646-1")

(defun use-default-theme ()
  (interactive)
  ;;(load-theme 'default-black)
  (load-theme 'adwaita t)
  (when (boundp 'magnar/default-font)
    (set-face-attribute 'default nil :font magnar/default-font))
  (set-face-attribute 'default nil :font van/default-font))

(use-default-theme)

(provide 'appearance)

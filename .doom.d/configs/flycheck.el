(use-package! flycheck
  :bind (:map flycheck-mode-map
              ("<f2>" . #'flycheck-next-error)
              ("S-<f2>" . #'flycheck-previous-error)
              ("C-6" . (lambda ()
                          (interactive)
                          (flycheck-list-errors)
                          (select-window (get-buffer-window flycheck-error-list-buffer)))))
  :config
  (setq flycheck-display-errors-delay 60))

(use-package! flycheck-posframe
  :custom
  (flycheck-posframe-border-width 1))

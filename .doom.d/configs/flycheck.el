(use-package! flycheck
  :bind (:map flycheck-mode-map
              ("<f2>" . #'flycheck-next-error)
              ("S-<f2>" . #'flycheck-previous-error))
  :config
  (setq flycheck-display-errors-delay 0.9
        flycheck-checker-error-threshold 999)
  (remove-hook 'flycheck-mode-hook #'+syntax-init-popups-h))

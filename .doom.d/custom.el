(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9e7119d21b31e80bc7c7ccee937cd687bfc1617b61b413e2ba1683df0fb10248" default))
 '(safe-local-variable-values
   '((eval setq ein:jupyter-server-command
      (concat
       (projectile-project-root)
       "/venv/bin/jupyter"))
     (eval progn
      (setq dap-python-executable
            (concat
             (projectile-project-root)
             "/venv/bin/python")))
     (projectile-project-test-cmd . "yarn nx run-many --all --target=test --output-style=static")
     (projectile-project-compilation-cmd . "yarn format:write && yarn nxmany --target build --output-style=static && yarn nxmany --target=lint --output-style=static -- --quiet")
     (lsp-eslint-quiet)
     (lsp-eslint-package-manager . "yarn")))
 '(sp-override-key-bindings '(("C-<right>") ("C-<left>") ("C-M-k") ("C-M-t")))
 '(warning-suppress-log-types '((lsp-mode) (defvaralias)))
 '(warning-suppress-types '(((undo discard-info)) (defvaralias))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold ((t (:weight extra-bold))))
 '(ts-fold-replacement-face ((t (:foreground nil :box nil :inherit font-lock-comment-face :weight light)))))
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'magit-clean 'disabled nil)

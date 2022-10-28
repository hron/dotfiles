(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((lsp-eslint-experimental-incremental-sync)
     (lsp-eslint-package-manager . "yarn")
     (eval setq ein:jupyter-server-command
      (concat
       (projectile-project-root)
       "/venv/bin/jupyter"))
     (checkdoc-package-keywords-flag)
     (toc-org-max-depth . 4)
     (eval progn
      (setq dap-python-executable
            (concat
             (projectile-project-root)
             "/venv/bin/python")))))
 '(sp-override-key-bindings '(("C-<right>") ("C-<left>"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(outline-1 ((t (:weight normal))))
 '(outline-2 ((t (:weight normal))))
 '(outline-3 ((t (:weight normal))))
 '(outline-4 ((t (:weight normal))))
 '(outline-5 ((t (:weight normal))))
 '(outline-6 ((t (:weight normal)))))

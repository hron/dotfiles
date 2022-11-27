(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((comment-fill-column . 80)
     (eval progn
      (setq dap-python-executable
            (concat
             (projectile-project-root)
             "/venv/bin/python")))
     (projectile-project-compilation-cmd . "gbp buildpackage --git-ignore-new --git-pristine-tar --git-pristine-tar-commit --git-debian-branch=ubuntu/jammy-json-rpc --git-builder='debuild -S -sa'")
     (projectile-project-test-cmd . "gbp buildpackage --git-ignore-new --git-pristine-tar --git-pristine-tar-commit --git-debian-branch=ubuntu/jammy-json-rpc")
     (lsp-eslint-quiet)
     (eval setq ein:jupyter-server-command
      (concat
       (projectile-project-root)
       "/venv/bin/jupyter"))
     (projectile-project-test-cmd . "yarn nx run-many --all --target=test --output-style=static")
     (projectile-project-compilation-cmd . "yarn format:write && yarn nxmany --target build --output-style=static && yarn nxmany --target=lint --output-style=static -- --quiet")
     (projectile-project-compilation-cmd . "yarn format:write && yarn nxmany --target=lint --output-style=static -- --quiet")
     (projectile-project-test-cmd . "yarn nxmany --target=test --output-style=static")
     (projectile-project-compilation-cmd . "yarn format:write && yarn nxmany --target=lint --output-style=static -- --quiet --fix")
     (vc-prepare-patches-separately)
     (diff-add-log-use-relative-names . t)
     (vc-git-annotate-switches . "-w")
     (flycheck-disabled-checkers quote
      (javascript-eslint emacs-lisp-checkdoc))
     (lsp-eslint-quiet . t)
     (lsp-eslint-experimental-incremental-sync)
     (lsp-eslint-package-manager . "yarn")
     (mocha-project-test-directory . "packages/**/test/**/*.test.ts")))
 '(sp-override-key-bindings '(("C-<right>") ("C-<left>")))
 '(warning-suppress-log-types '((lsp-mode) (defvaralias)))
 '(warning-suppress-types '((lsp-mode) (defvaralias))))
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

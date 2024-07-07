(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((company-idle-delay . 0.0)
     (company-idle-delay)
     (vc-prepare-patches-separately)
     (diff-add-log-use-relative-names . t)
     (vc-git-annotate-switches . "-w")
     (testlab-test-framework . jest)
     (projectile-project-test-cmd . "yarn nx run-many --all --target=test --output-style=static")
     (projectile-project-compilation-cmd . "yarn format:write && yarn nxmany --target build --output-style=static && yarn nxmany --target=lint --output-style=static -- --quiet")
     (lsp-eslint-quiet)
     (lsp-eslint-package-manager . "yarn")))
 '(sp-override-key-bindings '(("C-<right>") ("C-<left>") ("C-M-k") ("C-M-t"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ts-fold-replacement-face ((t (:foreground nil :box nil :inherit font-lock-comment-face :weight light)))))
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'magit-clean 'disabled nil)
(put 'customize-face 'disabled nil)

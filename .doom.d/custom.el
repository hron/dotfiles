(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((flycheck-disabled-checkers quote
      (javascript-eslint emacs-lisp-checkdoc))
     (lsp-eslint-quiet . t)
     (lsp-eslint-experimental-incremental-sync)
     (lsp-eslint-package-manager . "yarn")
     (mocha-project-test-directory . "packages/**/test/**/*.test.ts")))
 '(sp-override-key-bindings '(("C-<right>") ("C-<left>"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ts-fold-replacement-face ((t (:foreground nil :box nil :inherit font-lock-comment-face :weight light)))))
(put 'narrow-to-region 'disabled nil)

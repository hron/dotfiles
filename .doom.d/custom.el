(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((+format-on-save-disabled-modes quote
                                     (clojure-mode clojurescript-mode))
     (+format-on-save-disabled-modes quote
                                     (clojure-mode))
     (+format-with . phpcs)
     (+format-with quote phpcs)
     (+format-with-lsp-mode)
     (elisp-autofmt-format-quoted)
     (+format-inhibit . t)
     (eval progn
           (remove-hook 'before-save-hook #'ws-butler-before-save t)
           (remove-hook 'before-save-hook #'format-all-buffer t))
     (eval remove-hook 'before-save-hook #'format-all-buffer t)
     (phpunit-root-directory-in-docker . "/www")
     (eval setq phpunit-executable
           (executable-find "docker"))))
 '(sp-override-key-bindings
   '(("C-<right>")
     ("C-<left>")
     ("M-m" . aleksei/sp-beginning-or-end-of-sexp)
     ("C-M-k")
     ("C-M-t")
     ("C-M-e"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'magit-clean 'disabled nil)
(put 'customize-face 'disabled nil)

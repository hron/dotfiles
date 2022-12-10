;;; ../src/dotfiles/.doom.d/configs/eshell.el -*- lexical-binding: t; -*-

(defun aleksei/eshell-default-prompt-fn ()
  "Generate the prompt string for eshell. Use for `eshell-prompt-function'."
  (require 'shrink-path)
  (concat (if (bobp) "" "\n")
          (let ((pwd (eshell/pwd)))
            (propertize (if (equal pwd "~")
                            pwd
                          (abbreviate-file-name (shrink-path-file pwd)))
                        'face '+eshell-prompt-pwd))
          "\n"
          (propertize " λ" 'face (if (zerop eshell-last-command-status) 'success 'error))
          " "))

(after! eshell
  (setq eshell-prompt-function #'aleksei/eshell-default-prompt-fn))

(use-package! esh-mode
  :bind (:map eshell-mode-map
              ("<home>" . eshell-bol)
              ("C-r" . consult-history)))

(after! eshell
  (remove-hook 'eshell-mode-hook #'hide-mode-line-mode))

(use-package! em-hist
  :bind (:map eshell-hist-mode-map
              ("<up>" . nil)
              ("<down>" . nil)))
(use-package! em-prompt
  :bind (:map eshell-prompt-mode-map
              ("<home>" . eshell-bol)
              ("C-<prior>" . eshell-previous-prompt)
              ("C-<next>" . eshell-next-prompt)))

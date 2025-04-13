;;; ../src/dotfiles/.doom.d/configs/eshell.el -*- lexical-binding: t; -*-

;; (map! "C-`" #'project-eshell)

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
              ("<down>" . nil)
              ("C-<up>" . nil)
              ("C-<down>" . nil)
              ("M-<up>" . eshell-previous-matching-input-from-input)
              ("M-<down>" . eshell-next-matching-input-from-input)))

(use-package! em-prompt
  :bind (:map eshell-prompt-mode-map
              ("<home>" . eshell-bol)
              ("M-r" . recompile)
              ("M-<prior>" . eshell-previous-prompt)
              ("M-<next>" . eshell-next-prompt)))

;; (defun eshell/less (&rest args)
;;   "Invoke `view-file' on a file. \"less +42 foo\" will go to line 42 in
;;     the buffer for foo."
;;   (while args
;;     (if (string-match "\\`\\+\\([0-9]+\\)\\'" (car args))
;;         (let* ((line (string-to-number (match-string 1 (pop args))))
;;                (file (pop args)))
;;           (tyler-eshell-view-file file)
;;           (goto-line line))
;;       (tyler-eshell-view-file (pop args)))))
(defun eshell/less (&rest files)
  "Essentially an alias to the `view-file' function."
  (eshell-fn-on-files 'view-file 'view-file-other-window files))
(defalias 'eshell/more 'eshell/less)

(setenv "AWS_PAGER" "")
(setenv "PAGER" "")

(map! "C-`" #'+eshell/toggle)

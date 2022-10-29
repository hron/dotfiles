;;; ../src/dotfiles/.doom.d/configs/just-cua.el -*- lexical-binding: t; -*-

(use-package! emacs
  :custom
  (cua-remap-control-z nil)
  (cua-prefix-override-inhibit-delay 0.0000000001)
  (cua-rectangle-mark-key [(control shift return)])
  :config (cua-mode +1))

(defun aleksei/define-global-key-translations (&optional frame)
  "ESC according modern conventions"
  (with-selected-frame (or frame (selected-frame))
    ;; C-x
    ;; Escape
    (define-key key-translation-map (kbd "ESC") (kbd "C-g"))))

(aleksei/define-global-key-translations)
(add-hook 'after-make-frame-functions 'aleksei/define-global-key-translations)
(global-unset-key (kbd "C-<return>"))

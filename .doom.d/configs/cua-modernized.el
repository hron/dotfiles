;;; ../src/dotfiles/.doom.d/configs/cua-modernized.el -*- lexical-binding: t; -*-

(defun aleksei/copy-line-or-region ()
  "Copy the region if it's active otherwise copy current line"
  (interactive)
  (if (region-active-p)
      (call-interactively 'kill-ring-save)
    (save-excursion
      (call-interactively
       '(lambda ()
          (interactive)
          (copy-region-as-kill (point-at-bol) (point-at-eol)))))))

(defun aleksei/cut-line-or-region ()
  "Cut the region if it's active otherwise cut current line"
  (interactive)
  (if (region-active-p)
        (call-interactively 'kill-region)
    (save-excursion
      (call-interactively 'kill-whole-line))))

;; We don't need cua-mode!
(defun aleksei/define-global-key-translations (&optional frame)
  "Re-map C-x/c/v and ESC according modern conventions"
  (with-selected-frame (or frame (selected-frame))
    ;; C-x
    (keyboard-translate ?\C-t ?\C-x)
    (keyboard-translate ?\C-x 'control-x)
    (global-set-key [control-x] 'aleksei/cut-line-or-region)
    ;; C-c
    (keyboard-translate ?\C-d ?\C-c)
    (keyboard-translate ?\C-c 'control-c)
    (global-set-key [control-c] 'aleksei/copy-line-or-region)
    ;; C-v
    (keyboard-translate ?\C-v 'control-v)
    (global-set-key [control-v] 'yank)
    ;; Escape
    (define-key key-translation-map (kbd "ESC") (kbd "C-g"))))

(after! doom-keybinds
  (aleksei/define-global-key-translations)
  (add-hook 'after-make-frame-functions 'aleksei/define-global-key-translations)
  (global-unset-key (kbd "C-<return>")))

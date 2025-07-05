;;; aleksei-vterm.el --- vterm configuration -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: June 06, 2025
;; Modified: June 06, 2025
;; Version: 0.0.1
;; Package-Requires: ((emacs "30.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  vterm configuration
;;
;;; Code:

(defun aleksei-vterm-redo ()
  "Send `C-S-z' to the libvterm."
  (interactive)
  (vterm-send "M-z"))

(defun aleksei-vterm-copy-mode-next-prompt ()
  (interactive)
  (vterm-copy-mode)
  (call-interactively #'vterm-next-prompt))

(defun aleksei-vterm-copy-mode-previous-prompt ()
  (interactive)
  (vterm-copy-mode)
  (call-interactively #'vterm-previous-prompt))

(defun aleksei-vterm-new-tab ()
  (interactive)
  (vterm 'new))

(defun aleksei-vterm-toggle ()
  (interactive)
  (if-let* ((win (get-buffer-window "*vterm*")))
      (delete-window win)
    (call-interactively #'vterm-other-window)))

(use-package vterm
  :bind (("C-`" . #'aleksei-vterm-toggle)
         :map vterm-mode-map
         ("C-S-z" . #'aleksei-vterm-redo)
         ("C-v" . #'vterm-yank)
         ("C-<backspace>" . #'vterm-send-meta-backspace)
         ("C-<delete>" . #'vterm--self-insert)
         ("C-S-<SPC>" . #'vterm-copy-mode)
         ("C-w" . nil)
         ("C-p" . nil)
         ("M-i" . nil)
         ("C-b" . #'switch-to-buffer)
         ("C-e" . #'aleksei/consult-project)
         ("M-<up>" . #'aleksei-vterm-copy-mode-previous-prompt)
         ("M-<down>" . #'aleksei-vterm-copy-mode-next-prompt)
         ("C-t" . #'aleksei-vterm-new-tab)
         ("<f3>" . nil)
         ("<f4>" . nil)
         ("C-j" . nil)
         :map vterm-copy-mode-map
         ("M-<up>" . #'vterm-previous-prompt)
         ("M-<down>" . #'vterm-next-prompt)
         ("C-t" . #'aleksei-vterm-new-tab))
  :custom
  (vterm-shell "/usr/bin/fish")
  (vterm-max-scrollback 100000)
  (vterm-clear-scrollback-when-clearing t)
  :config
  ;; (add-hook 'vterm-mode-hook 'compilation-shell-minor-mode)
  (add-hook 'vterm-mode-hook #'(lambda () (setq-local cua-mode nil)))
  (add-hook 'vterm-mode-hook #'(lambda () (setq-local undo-fu-mode nil)))
  (add-hook 'vterm-mode-hook #'(lambda () (setq-local pixel-scroll-mode nil)))
  (add-hook 'vterm-mode-hook #'(lambda () (setq-local pixel-scroll-precision-mode nil)))
  (add-hook 'vterm-mode-hook #'(lambda () (setq-local global-hl-line-mode nil))))

(provide 'aleksei-vterm)
;;; aleksei-vterm.el ends here

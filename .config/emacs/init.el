;;; init.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: April 09, 2025
;; Modified: April 09, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/hron/dotfiles/.config/emacs
;; Package-Requires: ((emacs "29.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Aleksei Gusev"
      user-mail-address "aleksei.gusev@gmail.com")

(add-to-list 'load-path (locate-user-emacs-file "lisp"))

(use-package emacs
  :init
  (cua-mode +1)
  :custom
  (cua-remap-control-z nil)
  (cua-prefix-override-inhibit-delay 0.0000000001)
  (cua-rectangle-mark-key [(control shift return)]))

(use-package undo-fu
  :bind (("C-z"   . undo-fu-only-undo)
         ("C-S-z" . undo-fu-only-redo)))

(use-package emacs
  :init
  (defun algus/save-all-buffers ()
    "Saves all modified buffers, literally (save-some-buffers +1)"
    (interactive)
    (save-some-buffers +1))
  :bind (("C-<f2>" . list-processes)
         ("C-d" . duplicate-dwim)
         ("C-M-l" . indent-region)
         ("C-s" . algus/save-all-buffers)))

(setq-default cursor-type '(bar . 3))
(modify-all-frames-parameters
 '((font . "JetBrainsMono Nerd Font-10")))
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(fringe-mode (frame-char-width))

(use-package drag-stuff
  :bind (("M-<up>" . nil)
         ("M-<down>" . nil)
         ("M-S-<up>" . #'drag-stuff-up)
         ("M-S-<down>" . #'drag-stuff-down)))

(use-package anzu
  :init
  ;;;###autoload
  (defun aleksei/isearch-region-or-forward ()
    "Do incremental search forward, use region if it's active"
    (interactive)
    (if (use-region-p)
        (isearch-forward-thing-at-point)
      (isearch-forward)))
  (remove-hook 'isearch-mode-hook 'isearch-yank-kill)
  (global-anzu-mode +1)

  :bind (("C-f" . #'aleksei/isearch-region-or-forward)
         :map isearch-mode-map
         ("C-f" . #'isearch-repeat-forward)
         ("C-r" . #'anzu-query-replace-regexp)
         ("S-<return>" . #'isearch-repeat-backward)
         ("<return>" . #'isearch-repeat-forward)
         ("C-g" . #'isearch-exit)
         ("C-v" . #'isearch-yank-kill)
         :map minibuffer-local-isearch-map
         ("C-f" . #'isearch-forward-exit-minibuffer)
         ("C-r" . #'isearch-backward-exit-minibuffer)
         ("C-v" . #'isearch-yank-kill))

  :custom (search-exit-option . 'edit))


(use-package consult
  :bind (:map global-map
         ("C-b" . consult-buffer)
         :map minibuffer-local-map
         ("C-f" . consult-history)
         ("C-r" . consult-history)))

(use-package vertico
  :bind (:map minibuffer-local-map
              ("C-s" . nil)
              ("<prior>" . vertico-scroll-down)
              ("<next>" . vertico-scroll-up)
              ("C-j" . vertico-exit-input))
  :config
  (setq vertico-buffer-display-action '(display-buffer-below-selected (side . bottom)))
  ;; (vertico-buffer-mode +1)
  )

(use-package embark
  :bind (:map global-map
         ("M-<return>" . embark-act)
         ("C-;" . nil)
         :map minibuffer-local-map
         ("M-<return>" . embark-act)
         :map minibuffer-mode-map
         ("M-<return>" . embark-act))
  :custom
  (embark-indicators '(embark--vertico-indicator
                       embark-highlight-indicator
                       embark-isearch-highlight-indicator))
  (embark-prompter 'embark-completing-read-prompter))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :hook (doom-modeline-mode . size-indication-mode) ; filesize in modeline
  :hook (doom-modeline-mode . column-number-mode)   ; cursor column in modeline
  :config
  (setq doom-modeline-major-mode-icon t
        doom-modeline-buffer-file-name-style 'file-name
        doom-modeline-height (+ (frame-char-height) 8)))

(use-package gptel
  :bind (:map global-map
              ("C-<return>" . gptel-menu)
              ;; :map gptel-mode
              ;; ("C-<return>" . gptel-send)
              )
  :config (setq gptel-model "gpt-4o"))

(use-package magit
  :bind (:map magit-section-mode-map
         ("C-<tab>" . nil)
         ("<C-iso-lefttab>" . nil)
         :map magit-mode-map
         ("C-w" . delete-window)))

;; emacs-lisp-mode
(use-package emacs
  :bind (:map emacs-lisp-mode-map
              ("C-q" . describe-symbol))
  :hook ((emacs-lisp-mode . (lambda () (setq tab-width 2)))))

(use-package ert
  :bind (:map emacs-lisp-mode-map
              ("C-; f" . ert)))

(use-package expand-region
  :bind (("C-h" . er/expand-region)
         ("C-S-h" . er/contract-region)))

(use-package crux
  :bind (("<home>" . crux-move-beginning-of-line)))

(require 'algus-org)

(provide 'init)
;;; init.el ends here

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

(provide 'init)
;;; init.el ends here

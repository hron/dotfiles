;;; early-init.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: April 09, 2025
;; Modified: April 09, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/hron/early-init
;; Package-Requires: ((emacs "30.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      ring-bell-function 'ignore
      use-dialog-box nil
      use-file-dialog t
      use-short-answers t
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-x-resources t
      inhibit-startup-buffer-menu nil)

;; straight.el bootstrap
(setq straight-use-package-by-default t
      package-enable-at-startup nil
      use-package-always-defer t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(use-package emacs
  :init
  ;; Do not extend it to the end of the line
  (custom-set-faces
   '(region ((t :extend nil))))
  :custom
  (modus-themes-common-palette-overrides
   '(;; Make the region to change only the background
     (bg-region bg-ochre)
     (fg-region unspecified)))
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs t)
  :unless noninteractive)

(use-package auto-dark
  :init
  (auto-dark-mode)
  :custom
  (auto-dark-themes '((modus-vivendi) (modus-operandi)))
  :unless noninteractive)

(defun early-init--define-global-key-translations (&optional frame)
  "Configure ESC according modern conventions for FRAME."
  (with-selected-frame (or frame (selected-frame))
    ;; C-x
    ;; Escape
    (define-key key-translation-map (kbd "ESC") (kbd "C-g"))))
(add-hook 'after-make-frame-functions 'early-init--define-global-key-translations)

(provide 'early-init)
;;; early-init.el ends here

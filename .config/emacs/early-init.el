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

(unless (featurep 'mps)
  (if noninteractive  ; in CLI sessions
      ;; PERF: GC deferral is less important in the CLI, but still helps script
      ;;   startup times. Just don't set it too high to avoid runaway memory
      ;;   usage in long-running elisp shell scripts.
      (setq gc-cons-threshold 134217728  ; 128mb
            ;; Backported from 29 (see emacs-mirror/emacs@73a384a98698)
            gc-cons-percentage 1.0)
    ;; We rely on gmch-mode
    (setq gc-cons-threshold most-positive-fixnum)))

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      ring-bell-function 'ignore
      use-dialog-box nil
      use-file-dialog t
      use-short-answers t
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-x-resources t
      inhibit-startup-buffer-menu nil
      use-package-always-ensure t
      use-package-always-pin "nongnu")

(defun early-init--define-global-key-translations (&optional frame)
  "Configure ESC according modern conventions for FRAME."
  (with-selected-frame (or frame (selected-frame))
    ;; C-x
    ;; Escape
    (define-key key-translation-map (kbd "ESC") (kbd "C-g"))))
(add-hook 'after-make-frame-functions 'early-init--define-global-key-translations)

(custom-set-faces
 '(region ((t :extend nil))))
(custom-set-variables
 '(modus-themes-common-palette-overrides
   '(;; Make the region to change only the background
     (bg-region bg-ochre)
     (fg-region unspecified)))
 '(modus-themes-italic-constructs t)
 '(modus-themes-bold-constructs t)
 '(auto-dark-themes '((modus-vivendi) (modus-operandi))))

(add-to-list 'load-path (expand-file-name "elpa/auto-dark-20250812.10" user-emacs-directory))
(when (require 'auto-dark nil t)
  (unless auto-dark-detection-method
    (setq auto-dark-detection-method
          (auto-dark--determine-detection-method)))
  (auto-dark--set-theme (if (eq (auto-dark--current-system-mode) 'dark) 'dark 'light)))

(provide 'early-init)
;;; early-init.el ends here

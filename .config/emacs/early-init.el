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
      use-package-always-ensure t)

(setq elpaca-lock-file (expand-file-name "elpaca-lock.el" user-emacs-directory))
;; Example Elpaca configuration -*- lexical-binding: t; -*-
(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

(add-hook 'elpaca-log-mode-hook #'elpaca-log-update-mode)

(use-package emacs
  :ensure nil
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


(unless noninteractive
  (add-to-list 'load-path (expand-file-name "elpaca/builds/auto-dark" user-emacs-directory))
  (when (require 'auto-dark nil t)
    (customize-set-variable 'auto-dark-themes '((modus-vivendi) (modus-operandi)))

    (defun auto-dark--current-mode-dbus ()
      "Use Emacs built-in D-Bus function to determine if dark theme is enabled."
      (pcase (caar (dbus-ignore-errors
                     (dbus-call-method
                      :session
                      "org.freedesktop.portal.Desktop"
                      "/org/freedesktop/portal/desktop"
                      "org.freedesktop.portal.Settings" "Read"
                      "org.freedesktop.appearance" "color-scheme")))
        (1 'dark)
        (t 'light)))

    (auto-dark-mode +1)))

(use-package auto-dark
  ;; :init
  ;; (auto-dark-mode)
  ;; :custom
  ;; (auto-dark-themes '((modus-vivendi) (modus-operandi)))
  ;; :unless noninteractive
  )

(defun early-init--define-global-key-translations (&optional frame)
  "Configure ESC according modern conventions for FRAME."
  (with-selected-frame (or frame (selected-frame))
    ;; C-x
    ;; Escape
    (define-key key-translation-map (kbd "ESC") (kbd "C-g"))))
(add-hook 'after-make-frame-functions 'early-init--define-global-key-translations)

(provide 'early-init)
;;; early-init.el ends here

;;; aleksei-windows.el --- Defines windows related behavior for my taste -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: June 06, 2025
;; Modified: June 06, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/hron/aleksei-windows
;; Package-Requires: ((emacs "30.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Defines windows related behavior for my taste
;;
;;; Code:

(use-package emacs
  :ensure nil
  :bind (("C-<next>" . #'other-window)
         ("C-<prior>" . (lambda () (interactive) (other-window -1)))
         ("C-j" . #'window-toggle-side-windows)
         ("C-w" . #'delete-window)
         ("M-i" . #'aleksei-windows--delete-other-windows)))

(defun aleksei-windows--delete-other-windows ()
  "Delete all other windows except the current one and side windows."
  (interactive)
  (let ((current (selected-window)))
    (walk-windows (lambda (w)
                    (when (and (not (eq w current))
                               (eq (window-parameter w 'window-side)
                                   (window-parameter current 'window-side)))
                      (delete-window w))))))

(defun aleksei-windows--display-below-fit-and-select (buffer &optional _alist)
  "Display BUFFER at the bottom of the window, apply ALIST.

Fit the height to the content, and select the window."
  (let ((window (display-buffer-below-selected buffer `((side . bottom)))))
    (fit-window-to-buffer window (floor (frame-height) 2))
    (select-window window)  ;; Select the window displaying the buffer
    window))

(defun aleksei-windows--2-columns-layout-p (&rest _args)
  "Detect if there is enough width to use 2 columns layout."
  (>= (frame-width) 200))

(setq display-buffer-alist
      '(
        ((or . ((derived-mode . process-menu-mode)
                (derived-mode . flycheck-error-list-mode)
                "\\*RE-Builder\\*"
                ;; "\\*diff-hl"
                ))
         (display-buffer-reuse-mode-window
          aleksei-windows--display-below-fit-and-select))

        ((or . ("\\*Org Agenda"
                "\\*doom:scratch"
                (derived-mode . magit-status-mode)))
         (display-buffer-reuse-window
          display-buffer-same-window))

        ;; 2 column layout
        ((and . (aleksei-windows--2-columns-layout-p
                 (or . ("\\*ChatGPT"
                        "\\*Gemini"
                        "^magit-log"
                        "^magit-revision"
                        "^magit-diff"
                        "\\*Man"
                        "^\\*vterm"
                        "^\\*Embark Export"
                        "^\\*Occur\\*"
                        (derived-mode . compilation-mode)
                        (derived-mode . comint-mode)
                        (derived-mode . grep-mode)))))
         (display-buffer-reuse-window
          display-buffer-in-side-window)
         (side . left)
         (window-width . .5)
         (slot . 0))

        ((and . (aleksei-windows--2-columns-layout-p
                 (or . ("^\\*helpful"
                        "Output\\*$"
                        "^\\*lsp-help"
                        "^\\*eldoc\\*"
                        "^\\*info\\*"
                        "^\\*ert"
                        "^\\*Help"
                        "^\\*Apropos\\*"
                        "^\\*Backtrace\\*"))))
         (display-buffer-reuse-window
          display-buffer-in-side-window)
         (side . left)
         (window-width . .5)
         (slot . 0))

        ;; 1 column layout
        ((or . ("\\*ChatGPT"
                "\\*Gemini"
                "^magit-log"
                "^magit-revision"
                ;; "^*magit-diff"
                "\\*Man"))
         (display-buffer-reuse-window
          display-buffer-same-window))

        ((or . ("^\\*helpful"
                "Output\\*$"
                "^\\*lsp-help"
                "^\\*eldoc\\*"
                "^\\*info\\*"
                "^\\*Help"
                "^\\*Apropos\\*"
                "^\\*vterm"
                "^\\*ert"
                "^\\*Embark Export"
                "^\\*Backtrace\\*"
                "^\\*Occur\\*"
                (derived-mode . compilation-mode)
                (derived-mode . comint-mode)
                (derived-mode . grep-mode)))
         (display-buffer-reuse-window
          display-buffer-in-side-window)
         (side . bottom)
         (window-height . .33))))

(defvar aleksei-windows--redisplay-last-frame-width nil)

(defun aleksei-windows--frame-size-changed-p ()
  "Non-nil if a change in frame size is detected."
  (let ((new-size (cons (frame-width) (frame-height))))
    (cond ((null aleksei-windows--redisplay-last-frame-width)
           (setq aleksei-windows--redisplay-last-frame-width new-size)
           nil)
          ((not (equal aleksei-windows--redisplay-last-frame-width new-size))
           (setq aleksei-windows--redisplay-last-frame-width new-size)))))

(defun aleksei-windows--redisplay-side-windows (&optional frame)
  (interactive)
  (when (and (aleksei-windows--frame-size-changed-p))
    (let ((closed-bufs))
      (dolist (win (window-list frame nil))
        (when (and (window-parameter win 'window-side)
                   (window-live-p win))
          (push (window-buffer win) closed-bufs)
          (delete-window win)))
      (dolist (buf closed-bufs)
        (pop-to-buffer buf)))))

(add-hook 'window-size-change-functions #'aleksei-windows--redisplay-side-windows)

(provide 'aleksei-windows)
;;; aleksei-windows.el ends here

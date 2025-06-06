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
				 ("C-p" . #'window-toggle-side-windows)
				 ("C-w" . #'delete-window)
				 ("M-i" . #'delete-other-windows)))

(defvar aleksei-windows--default-side-window-width .5)
(defvar aleksei-windows--default-side-window-height .33)

(defun aleksei-windows--display-below-fit-and-select (buffer &optional _alist)
	"Display BUFFER at the bottom of the window, apply ALIST.

Fit the height to the content, and select the window."
	(let ((window (display-buffer-below-selected buffer `((side . bottom)))))
		(fit-window-to-buffer window (floor (frame-height) 2))
		(select-window window)  ;; Select the window displaying the buffer
		window))

(defun aleksei-windows--display-buffer-in-side-window (buffer &optional alist)
	"Display BUFFER at the appropriate place depending on the current frame width"
	(let* ((side-width (or (cdr (assq 'side-width alist)) aleksei-windows--default-side-window-width))
				 (side-height (or (cdr (assq 'side-height alist)) aleksei-windows--default-side-window-height))
				 (wide-frame-opts `(list
														(window-width . ,side-width)
														(side . left)))
				 (narrow-frame-opts `(list
															(window-height . ,side-height)
															(side . bottom))))

		(display-buffer-in-side-window
		 buffer
		 (append alist
						 (if (aleksei-windows--2-columns-layout-p) wide-frame-opts narrow-frame-opts)))))

(defun aleksei-windows--display-buffer-in-side-window-if-wide (buffer &optional alist)
	(if (aleksei-windows--2-columns-layout-p)
			(display-buffer-in-side-window
			 buffer
			 (append alist  `(list (side . left)
														 (window-width . ,aleksei-windows--default-side-window-width))))
		(display-buffer-same-window buffer alist)))

(defun aleksei-windows--2-columns-layout-p ()
	(>= (frame-width) 200))

(defun aleksei-windows--1-column-layout-p ()
	(not (aleksei-windows--2-columns-layout-p)))

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

				((or . ("\\*ChatGPT"
								"^magit-log"
								"^magit-revision"
								;; "^*magit-diff"
								"\\*Man"))
				 (aleksei-windows--display-buffer-in-side-window-if-wide))

				((or . ("\\*ert"))
				 (aleksei-windows--display-buffer-in-side-window-if-wide)
				 (slot . 1))

				((or . ("^\\*helpful"
								"Output\\*$"
								"^\\*lsp-help"
								"^\\*eldoc\\*"
								"^\\*Help"))
				 (display-buffer-reuse-window
					aleksei-windows--display-buffer-in-side-window)
				 (slot . 1))

				((or . ((derived-mode . compilation-mode)
								(derived-mode . comint-mode)
								(derived-mode . grep-mode)))
				 (display-buffer-reuse-window
					aleksei-windows--display-buffer-in-side-window))))

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

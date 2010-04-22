;;; emacs-rc-dired.el --- dires options

;; Copyright (C) 2004, 2008  Free Software Foundation, Inc.

;; Author: Aleksei Gusev <aleksei.gusev@tut.by>
;; Keywords:

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;

;;; Code:

(require 'dired)

;; The variable `dired-recursive-deletes' controls whether the delete
;; command will delete non-empty directories (including their contents).
;; The default is to delete only empty directories.
(setq dired-recursive-deletes 'top)

;; The variable `dired-recursive-copies' controls whether
;; directories are copied recursively.  The default is to not copy
;; recursively, which means that directories cannot be copied.
(setq dired-recursive-copies 'always)

;;   "*Switches passed to `ls' for Dired.  MUST contain the `l'
;; option.  May contain all other options that don't contradict `-l';
;; may contain even `F', `b', `i' and `s'.  See also the variable
;; `dired-ls-F-marks-symlinks' concerning the `F' switch.  On systems
;; such as MS-DOS and MS-Windows, which use `ls' emulation in Lisp,
;; some of the `ls' switches are not supported; see the doc string of
;; `insert-directory' in `ls-lisp.el' for more details."
(setq dired-listing-switches "-ahl --group-directories-first")

;; If you change the variable DIRED-ISEARCH-FILENAMES to `t', then the
;; usual search commands also limit themselves to the file names; for
;; instance, `C-s' behaves like `M-s f C-s'
(setq dired-isearch-filenames t)

;; Directory for `move-file-to-trash' to move files and directories
;; to. This directory is only used when the function
;; `system-move-file-to-trash' is not defined. Relative paths are
;; interpreted relative to `default-directory'. See also
;; `delete-by-moving-to-trash'.
(setq trash-directory "~/.local/share/Trash/files/")

;;    On some systems, there is a facility called the "Trash" or
;; "Recycle Bin", but Emacs does _not_ use it by default. Thus, when
;; you delete a file in Dired, it is gone forever. However, you can
;; tell Emacs to use the Trash for file deletion, by changing the
;; variable `delete-by-moving-to-trash' to `t'. *Note Misc File Ops::,
;; for more information about the Trash.
(setq delete-by-moving-to-trash nil)

(add-hook 'dired-mode-hook
	  (lambda ()
	    (define-key dired-mode-map "W" 'woman-dired-find-file)))

(require 'dired-x)

(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")
	    ;; Set dired-x global variables here.  For example:
	    ;; (setq dired-guess-shell-gnutar "gtar")
	    ;; (setq dired-x-hands-off-my-keys nil)
	    ))
(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    (dired-omit-mode 1)
	    ))

(setq dired-omit-files-p t)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))

(define-key global-map "\C-x\C-j" 'dired-jump)
(define-key global-map "\C-x4\C-j" 'dired-jump-other-window)

;; Virtual dired
(setq auto-mode-alist (cons '("[^/]\\.dired$" . dired-virtual-mode)
			    auto-mode-alist))


(provide 'emacs-rc-dired)

;;; emacs-rc-dired.el ends here

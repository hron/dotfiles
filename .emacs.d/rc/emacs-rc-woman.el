;;; emacs-rc-woman.el --- WoMan customizing

;; Copyright (C) 2004  Free Software Foundation, Inc.

;; Author: Aleksei Gusev <aleksei.gusev@tut.by>
;; Keywords: local

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

;; An integer specifying the right margin for formatted text.
(setq woman-fill-column 78)

;; If non-`nil' then use a dedicated frame for displaying WoMan
;; windows.  This is useful only when WoMan is run under a window
;; system such as X or Microsoft Windows that supports real multiple
;; frames, in which case the default value is non-`nil'.
(setq woman-use-own-frame nil)

(defun woman-reformat-last-file-with-toggle-fill-frame ()
  "Reformat last file, e.g. after changing fill column after toggling
fill frame option."
  (interactive)
  (woman-toggle-fill-frame)
  (woman-reformat-last-file))

(add-hook 'woman-mode-hook
	  '(lambda ()
	     (define-key woman-mode-map "R"
	       'woman-reformat-last-file-with-toggle-fill-frame)))

(provide 'emacs-rc-woman)
;;; emacs-rc-woman.el ends here

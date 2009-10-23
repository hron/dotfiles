;;; emacs-rc-octave.el --- octave mode customisation.

;; Copyright (C) 2005  Free Software Foundation, Inc.

;; Author: Aleksei Gusev <ag@aichyna.com>
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

(add-hook 'octave-mode-hook
	  (lambda ()
	    (abbrev-mode 1)
	    (auto-fill-mode 1)
	    (flyspell-prog-mode)
	    (if (eq window-system 'x) (font-lock-mode 1))
	    (local-set-key "\M-;" 'comment-dwim)
	    (local-set-key "\C-m" (key-binding "\C-j"))
	    (local-set-key "\C-c="
			   (lambda ()
			     (interactive)
			     (align-string (region-beginning) (region-end) "=" 1)))
	    (setq octave-auto-indent nil
		  octave-auto-newline nil)))

(autoload 'octave-help "octave-hlp" nil t)

(provide 'emacs-rc-octave)
;;; emacs-rc-octave.el ends here

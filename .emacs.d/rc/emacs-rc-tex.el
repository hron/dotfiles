;;; emacs-rc-tex.el --- TeX customisation file

;; Copyright (C) 2004, 2005  Free Software Foundation, Inc.

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

;; If you want to make AUC TeX aware of style files and multi-file
;; documents right away, insert the following in your `.emacs' file.
(setq-default TeX-master nil)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-default-mode 'latex-mode)

;; RefTeX contains code to interface with AUCTeX.  When this interface is
;; turned on, both packages will interact closely.  Instead of using
;; RefTeX's commands directly, you can then also use them indirectly as
;; part of the AUCTeX environment(1).  The interface is turned on with
(setq reftex-plug-into-AUCTeX t)

(add-hook 'TeX-mode-hook
          '(lambda ()
             (local-set-key "\\" 'TeX-electric-macro)
	     (local-set-key "\C-cc" 'my-reftex-citation)
	     (auto-fill-mode 1)
	     (flyspell-mode 1)
	     (reftex-mode 1)))

(setq TeX-view-style '(("^a4\\(?:dutch\\|paper\\|wide\\)?\\|sem-a4$" "xdvi %d -paper a4")
		       ("^a5\\(?:comb\\|paper\\)?$" "xdvi %d -paper a5")
		       ("^b5paper$" "xdvi %d -paper b5")
		       ("^letterpaper$" "xdvi %d -paper us")
		       ("^legalpaper$" "xdvi %d -paper legal")
		       ("^executivepaper$" "xdvi %d -paper 7.25x10.5in")
		       ("^landscape$" "xdvi %d -paper a4r -s 4")
		       ("." "xdvi %d -paper a4")))

(defun my-reftex-citation (&optional page-ref)
  (interactive "p")
  ;; Call true citation function.
  (reftex-citation)
  (save-excursion
    (let ((page-prefix "стр.~")
	  (page-number))
      (progn
	(setq page-number (read-from-minibuffer "Enter page number: " page-prefix))
	(search-backward "{")
	(insert (concat "[" page-number "]"))))))


;;; emacs-rc-tex.el ends here

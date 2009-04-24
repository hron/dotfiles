;;;emacs-rc-hippie-exp.el --- hippie-expand customization.

;; Copyright (C) 2008   <aleksei.gusev@warecorp.com>

;; Author:  <aleksei.gusev@warecorp.com>
;; Created: 04 Mar 2008
;; Version: $Id$
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
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; 

;;; Code:


(require 'hippie-exp)

;; Another useful expansion is to expand tags. I use it as a fallback
;; after the dabbrev expansions fail.
(defun he-tag-beg ()
  (let ((p
         (save-excursion 
           (backward-word 1)
           (point))))
    p))

(defun try-expand-tag (old)
  (unless  old
    (he-init-string (he-tag-beg) (point))
    (setq he-expand-list (sort
                          (all-completions he-search-string 'tags-complete-tag) 'string-lessp)))
  (while (and he-expand-list
              (he-string-member (car he-expand-list) he-tried-table))
              (setq he-expand-list (cdr he-expand-list)))
  (if (null he-expand-list)
      (progn
        (when old (he-reset-string))
        ())
    (he-substitute-string (car he-expand-list))
    (setq he-expand-list (cdr he-expand-list))
    t))


;; The list of expansion functions tried in order by `hippie-expand'.
;; To change the behavior of `hippie-expand', remove, change the order
;; of, or insert functions in this list.
(setq hippie-expand-try-functions-list
      '(try-complete-abbrev
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-expand-list try-expand-line 
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))

;;; emacs-rc-hippie-exp.el ends here

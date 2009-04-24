;;; procmail-mode.el --- procmailrc files mode.

;; Copyright (C) 2005  Warecorp

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

;; add -*- procmail -*- line on top of ~/.procmailrc
;; to activate automatically 

;;; Code:

(defun procmail-mode ()
  "Mode for highlighting procmailrc files"
  (interactive)
  (setq mode-name "Procmail"
major-mode 'procmail)

  (require 'font-lock)
  (make-local-variable 'font-lock-defaults)
  (setq procmail-font-lock-keywords
(list '("#.*"
. font-lock-comment-face)
      '("Return-Path:"       
. font-lock-type-face)         ; green
      '("^[\t ]*:.*"                
. font-lock-function-name-face) ; blue ?
      '("[A-Z_]+=.*"
;             '("[A-Za-z_]+=.*"
. font-lock-keyword-face)
      '("^[\t ]*\\*.*"
. font-lock-doc-face)          ; light brown
;             '("\$[A-Za-z0-9_]+"       
      '("^[\t ]*ml\/"
. font-lock-builtin-face)      ; violet
      '("^[\t ]*from\/"
. font-lock-reference-face)
      '("^[\t ]*junk\/"
. font-lock-constant-face)      ; turquoize
      '("^[\t ]*dm/"
. font-lock-warning-face)       ; red
      '("^[\t ]*not-found/"
. font-lock-variable-name-face) ; orange
      '("^[\t ]*to/"
. font-lock-string-face)        ; light brown
      ))
  (setq font-lock-defaults '(procmail-font-lock-keywords t))
  (font-lock-mode t) )

(provide 'procmail-mode)
;;; procmail-mode.el ends here

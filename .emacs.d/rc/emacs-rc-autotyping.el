;;; emacs-rc-autotyping.el --- preference for autotyping and autoinserting tool

;; Author: Aleksei Gusev <aleksei.gusev@tut.by>
;; Keywords: local

;;; Code:

;; When Auto-insert mode is enabled, when new files are created you can
;; insert a template for the file depending on the mode of the buffer.
(auto-insert-mode t)

;; Non-nil means ask user before auto-inserting.
;; When this is `function', only ask when called non-interactively.
(setq auto-insert-query nil)

;; Directory from which auto-inserted files are taken.
(setq auto-insert-directory "~/.emacs.d/insert/")

(define-auto-insert "\\.\\([Hh]\\|hh\\|hpp\\)\\'"
  '(
    "Short description: "
    "/* \n" 
    " * " (file-name-nondirectory (buffer-file-name)) " --- " str "
 *
 * Copyright (C) " (substring (current-time-string) -4) "  " (user-full-name)
    '(if (search-backward "&" (line-beginning-position) t)
	 (replace-match (capitalize (user-login-name)) t t))
    '(end-of-line 1) " <" (progn user-mail-address) ">
 *
 * Author: " (user-full-name)
    '(if (search-backward "&" (line-beginning-position) t)
	 (replace-match (capitalize (user-login-name)) t t))
    '(end-of-line 1) " <" (progn user-mail-address) ">
 * Created: " (shell-command-to-string "LANG=C date +'%d %b %Y'")
" * Version: $Id$
 *
 * This file is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This file is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

"
    '(setq v1
	   (upcase (concat (file-name-sans-extension
			    (file-name-nondirectory (buffer-file-name)))
			   "_"
			   (file-name-extension (buffer-file-name)))))
    "#ifndef " v1 \n
    "#define " v1 "\n\n"
    _ "\n\n#endif")
  )

(define-auto-insert "\\.\\([Cc]\\|cc\\|cpp\\)\\'"
  '(
    "Short description: "
    "/* \n" 
    " * " (file-name-nondirectory (buffer-file-name)) " --- " str "
 *
 * Copyright (C) " (substring (current-time-string) -4) "  " (user-full-name)
    '(if (search-backward "&" (line-beginning-position) t)
	 (replace-match (capitalize (user-login-name)) t t))
    '(end-of-line 1) " <" (progn user-mail-address) ">
 *
 * Author: " (user-full-name)
    '(if (search-backward "&" (line-beginning-position) t)
	 (replace-match (capitalize (user-login-name)) t t))
    '(end-of-line 1) " <" (progn user-mail-address) ">
 * Created: " (shell-command-to-string "LANG=C date +'%d %b %Y'")
" * Version: $Id$
 *
 * This file is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This file is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

"
    "#include \""
     (let ((stem (file-name-sans-extension buffer-file-name)))
       (cond ((file-exists-p (concat stem ".h"))
	      (file-name-nondirectory (concat stem ".h")))
	     ((file-exists-p (concat stem ".hh"))
	      (file-name-nondirectory (concat stem ".hh")))
	     ((file-exists-p (concat stem ".hpp"))
	      (file-name-nondirectory (concat stem ".hpp")))))
     & ?\" \n | -10
     _)
  )

(define-auto-insert "/bin/.*[^/]\\'"
  '(nil
"#! /bin/sh" "

#
# Copyright (C) " (substring (current-time-string) -4) "  " (user-full-name)
  '(if (search-backward "&" (line-beginning-position) t)
       (replace-match (capitalize (user-login-name)) t t))
  '(end-of-line 1) " <" (progn user-mail-address) ">
#
# Author: " (user-full-name)
  '(if (search-backward "&" (line-beginning-position) t)
       (replace-match (capitalize (user-login-name)) t t))
  '(end-of-line 1) " <" (progn user-mail-address) ">
# Created: " (shell-command-to-string "LANG=C date +'%d %b %Y'")
"# Version: $Id$
#
# This file is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This file is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#

" _
'(sh-mode)
))

(define-auto-insert "\\.el"
  '(
    "Short description: " 
    '(emacs-lisp-mode)
";;;" (file-name-nondirectory (buffer-file-name)) " --- " str "

;; Copyright (C) " (substring (current-time-string) -4) "  " (user-full-name)
  '(if (search-backward "&" (line-beginning-position) t)
       (replace-match (capitalize (user-login-name)) t t))
  '(end-of-line 1) " <" (progn user-mail-address) ">

;; Author: " (user-full-name)
  '(if (search-backward "&" (line-beginning-position) t)
       (replace-match (capitalize (user-login-name)) t t))
  '(end-of-line 1) " <" (progn user-mail-address) ">
;; Created: " (shell-command-to-string "LANG=C date +'%d %b %Y'")
";; Version: $Id$
;; Keywords: "
 '(require 'finder)
 ;;'(setq v1 (apply 'vector (mapcar 'car finder-known-keywords)))
 '(setq v1 (mapcar (lambda (x) (list (symbol-name (car x))))
		   finder-known-keywords)
	v2 (mapconcat (lambda (x) (format "%10.0s:  %s" (car x) (cdr x)))
	   finder-known-keywords
	   "\n"))
 ((let ((minibuffer-help-form v2))
    (completing-read "Keyword, C-h: " v1 nil t))
    str ", ") & -2 "

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

;; " _ "

;;; Code:



\(provide '"
       (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))
       ")
;;; " (file-name-nondirectory (buffer-file-name)) " ends here\n"))

(define-auto-insert "\\.[Tt][Ee][Xx]"
  '(
    "Short description: " 
    '(latex-mode)
"%%
%% " (file-name-nondirectory (buffer-file-name)) " --- " str "
%%
%% Copyright (C) " (substring (current-time-string) -4) "  " (user-full-name)
  '(if (search-backward "&" (line-beginning-position) t)
       (replace-match (capitalize (user-login-name)) t t))
  '(end-of-line 1) " <" (progn user-mail-address) ">
%%
%% Author: " (user-full-name)
  '(if (search-backward "&" (line-beginning-position) t)
       (replace-match (capitalize (user-login-name)) t t))
  '(end-of-line 1) " <" (progn user-mail-address) ">
%% Created: " (shell-command-to-string "LANG=C date +'%d %b %Y'")
"%% Version: $Id$
%%

" _
"\\documentclass[" (read-string "options, RET: ") & 93 | -1 123 (read-string "class: ") "}\n"
("package, %s: " "\\usepackage[" (read-string "options, RET: ") & 93 | -1 123 str "}\n")
_ "\n\\begin{document}\n" _ "\n\\end{document}"))

;;; emacs-rc-autotyping.el ends here

;;; emacs-rc-sh-scripts.el --- customizations for sh-mode

;; Copyright (C) 2004, 2005, 2007  Free Software Foundation, Inc.

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

(require 'sh-script)

(setq sh-shell 'sh
      sh-shell-file "/bin/sh")

(defun my-sh-mod-hook ()
  (abbrev-mode 1)
  )

(add-hook 'sh-mode-hook 'my-sh-mod-hook)

(setq shell-prompt-pattern "^.*[#$%>] *")
;; (add-hook 'sh-set-shell-hook 'sh-learn-buffer-indent)

;;; emacs-rc-sh-scripts.el ends here

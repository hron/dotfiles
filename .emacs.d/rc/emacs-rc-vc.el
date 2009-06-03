;;;emacs-rc-vc.el --- VC customization.

;; Copyright (C) 2009  Aleksei Gusev <aleksei.gusev@warecorp.com>

;; Author: Aleksei Gusev <aleksei.gusev@warecorp.com>
;; Created: 04 Jun 2009
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

(setq
 ;; Emacs normally  does not save  backup files for source  files that
 ;; are maintained  with version control.  If you want to  make backup
 ;; files even  for files that  use version control, set  the variable
 ;; `vc-make-backup-files' to a non-`nil' value.
 vc-make-backup-files t

 ;;    The variable  `vc-follow-symlinks' controls  what to do  when a
 ;; symbolic link points to a version-controlled file. If it is `nil',
 ;; VC only displays a warning message. If it is `t', VC automatically
 ;; follows the  link, and visits  the real file instead,  telling you
 ;; about this in the echo area.  If the value is `ask' (the default),
 ;; VC asks you each time whether to follow the link.
 vc-follow-symlinks t

 ;;    VC mode does much of its work by running the shell commands for
 ;; RCS,  CVS  and SCCS.  If  `vc-command-messages'  is non-`nil',  VC
 ;; displays messages  to indicate which  shell commands it  runs, and
 ;; additional messages when the commands finish.
 vc-command-messages t
 )

;;; emacs-rc-vc.el ends here

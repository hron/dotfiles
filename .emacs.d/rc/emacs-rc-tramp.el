;;;emacs-rc-tramp.el --- TRAMP package customization.

;; Copyright (C) 2005, 2007  Aleksei Gusev <aleksei.gusev@tut.by>

;; Author: Aleksei Gusev <aleksei.gusev@tut.by>
;; Created: 26 Aug 2005
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

(setq tramp-backup-directory-alist backup-directory-alist)

(setq tramp-auto-save-directory "~/.emacs.d/tramp-auto-save")
(setq tramp-shell-prompt-pattern shell-prompt-pattern)

;; (add-to-list 'tramp-default-proxies-alist
;; 	     '("\\.*\\'" "\\`root\\'" "/sshx:%h:"))

;;; emacs-rc-tramp.el ends here

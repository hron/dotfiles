;;;emacs-rc-view-mode.el --- View mode customization.

;; Copyright (C) 2007   <aleksei.gusev@warecorp.com>

;; Author:  <aleksei.gusev@warecorp.com>
;; Created: 27 Nov 2007
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

(add-hook 'view-mode-hook
	  '(lambda ()
	      (ruby-electric-mode 0)))
;;; emacs-rc-view-mode.el ends here

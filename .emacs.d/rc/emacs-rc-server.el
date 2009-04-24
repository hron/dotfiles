;;;emacs-rc-server.el --- server.el customization.

;; Copyright (C) 2007, 2008  Aleksei Gusev <aleksei.gusev@gmail.com>

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: 12 Mar 2007
;; Version: $Id$
;; Keywords: 

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
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


(add-hook 'server-switch-hook
	  (lambda nil
	    (let ((server-buf (current-buffer)))
	      (bury-buffer)
	      (switch-to-buffer-other-frame server-buf))))

(setq server-raise-frame nil)
;; (server-start)

;;; emacs-rc-server.el ends here

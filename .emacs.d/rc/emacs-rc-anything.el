;;;emacs-rc-anything-config.el --- anything.el customization.

;; Copyright (C) 2008   <aleksei.gusev@warecorp.com>

;; Author:  <aleksei.gusev@warecorp.com>
;; Created: 19 Jan 2008
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

(require 'anything-config)

(setq anything-sources
      (list anything-c-source-buffers
            anything-c-source-file-name-history
	    anything-c-source-bookmarks
            anything-c-source-info-pages
            anything-c-source-man-pages
            anything-c-source-locate
            anything-c-source-emacs-commands))

(global-set-key [f10] 'anything)

;;; emacs-rc-anything-config.el ends here

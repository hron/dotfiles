;;;emacs-rc-emms.el --- emms customization.

;; Copyright (C) 2005  Aleksei Gusev <aleksei.gusev@tut.by>

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: Fri May 29 14:00:35 EEST 2009
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

(require 'emms-setup)

;; -- Function: emms-all
;;     An Emms setup script.  Everything included in the `emms-standard'
;;     setup and adds all the stable features which come with the Emms
;;     distribution.
(emms-all)

(require 'emms-player-mpd)

(setq emms-player-mpd-server-name "localhost")
(setq emms-player-mpd-server-port "6600")

;; (add-to-list 'emms-info-functions 'emms-info-mpd)


;; The default directory to look for media files.
(setq emms-source-file-default-directory "~/Music/")

(setq emms-player-list '(emms-player-mpd))

;; A function to call that searches in a given directory all files
;; that match a given regex. DIR and REGEX are the only arguments
;; passed to this function.  You have two build-in options:
;; `emms-source-file-directory-tree-internal' will work always, but
;; might be slow.  `emms-source-file-directory-tree-find' will work
;; only if you have GNU find, but it's faster.
(setq emms-source-file-directory-tree-function
			'emms-source-file-directory-tree-find)

(setq emms-playlist-default-major-mode 'emms-playlist-mode)


;;; emacs-rc-emms.el ends here

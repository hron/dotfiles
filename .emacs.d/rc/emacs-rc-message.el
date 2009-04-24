;;; emacs-rc-message.el --- message mode customization

;; Copyright (C) 2004  Free Software Foundation, Inc.

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

;; 

;;; Code:

;;    `bbdb-insinuate-message' adds a binding for `M-TAB' to Message mode.
;; This will enable completion of addressees based on BBDB records. See
;; *Note Using Message Mode:: for more details on the operation of Message
;; mode BBDB record completion.
(bbdb-insinuate-message)

;;; emacs-rc-message.el ends here

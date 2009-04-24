;;;emacs-rc-gdb.el --- 

;; Copyright (C) 2007  Aleksei Gusev <aleksei.gusev@gmail.com>

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: 08 Сен 2007
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

;; If the variable `gdb-many-windows' is `nil' (the default value) then
;; `M-x gdb' normally displays only the GUD buffer.  However, if the
;; variable `gdb-show-main' is also non-`nil', it starts with two windows:
;; one displaying the GUD buffer, and the other showing the source for the
;; `main' function of the program you are debugging.
;;
;;    If `gdb-many-windows' is non-`nil', then `M-x gdb' displays the
;; following frame layout:
;;
;;      +--------------------------------+--------------------------------+
;;      |   GUD buffer (I/O of GDB)      |   Locals buffer                |
;;      |--------------------------------+--------------------------------+
;;      |   Primary Source buffer        |   I/O buffer for debugged pgm  |
;;      |--------------------------------+--------------------------------+
;;      |   Stack buffer                 |   Breakpoints buffer           |
;;      +--------------------------------+--------------------------------+
(setq gdb-many-windows nil)

;;    However, if `gdb-use-separate-io-buffer' is `nil', the I/O buffer
;; does not appear and the primary source buffer occupies the full width
;; of the frame.
(setq gdb-use-separate-io-buffer nil)

;; (setq gud-minor-mode t)

;;; emacs-rc-gdb.el ends here

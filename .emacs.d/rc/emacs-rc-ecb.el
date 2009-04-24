;;; emacs-rc-ecb.el --- ecb customizations

;; Copyright (C) 2004, 2007  Free Software Foundation, Inc.

;; Author: Aleksei Gusev <aleksei.gusev@tut.by>
;; Keywords: local

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
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

;; Подавляет вывод "советов дня".
(setq ecb-tip-of-the-day nil)

;; Where ECB can find your sources.
(setq ecb-source-path (concat (getenv "HOME") "/src"))

;; The style of the tree-buffers.
(setq ecb-tree-buffer-style 'image)

;; Which windows of ECB should be accessible by the ECB-adviced function
;; `other-window', an intelligent replacement for the Emacs standard version
;; of `other-window'. The following settings are possible:
(setq ecb-other-window-jump-behavior 'edit-and-compile)

;; Let Emacs temporally enlarge the compile-window of the ECB-layout.  This
;; option has only an effect if `ecb-compile-window-height' is not nil!
(setq ecb-compile-window-temporally-enlarge 'both)

;; Width of the compile-window.
;; Possible values are `frame' and `edit-window'.
(setq ecb-compile-window-width 'edit-window)

;;; emacs-rc-ecb.el ends here

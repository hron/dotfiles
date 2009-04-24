;;;emacs-rc-lsdb.el --- LSDB customization

;; Copyright (C) 2005  Aleksei Gusev <aleksei.gusev@tut.by>

;; Author: Aleksei Gusev <aleksei.gusev@tut.by>
;; Created: 28 Aug 2005
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


(require 'lsdb)

(setq lsdb-pop-up-windows nil)

(add-hook 'gnus-startup-hook 'lsdb-gnus-insinuate)
(add-hook 'message-setup-hook
          (lambda ()
            (define-key message-mode-map "\M-t" 'lsdb-complete-name)))
(add-hook 'gnus-summary-mode-hook
          (lambda ()
            (define-key gnus-summary-mode-map ":" 'lsdb-toggle-buffer)))


(provide 'emacs-rc-lsdb)
;;; emacs-rc-lsdb.el ends here

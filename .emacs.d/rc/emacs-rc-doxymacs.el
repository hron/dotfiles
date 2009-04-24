;;;emacs-rc-doxymacs.el --- doxymacs customization.

;; Copyright (C) 2007, 2008  Aleksei Gusev <aleksei.gusev@gmail.com>

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: 11 Сен 2007
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

;; FIXME: make detection of host, not just that it is debian
;; distribution.
(unless (string-match "Debian" (version))
  (require 'doxymacs)

  (add-hook 'c-mode-common-hook 'doxymacs-mode)

  ;; This will add the Doxygen keywords to c-mode and c++-mode only.
  (defun my-doxymacs-font-lock-hook ()
    (if (or (eq major-mode 'c-mode)
	    (eq major-mode 'c++-mode)
	    (eq major-mode 'php-mode))
        (doxymacs-font-lock)))
  (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook))

;;; emacs-rc-doxymacs.el ends here

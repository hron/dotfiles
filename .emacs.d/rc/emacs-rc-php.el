;;;emacs-rc-php.el --- php-mode customization

;; Copyright (C) 2007, 2008  Aleksei Gusev <aleksei.gusev@gmail.com>

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: 11 Апр 2007
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

(setq load-path
      (cons (expand-file-name "~/.emacs.d/packages/php_repl/data")
	    load-path))

(require 'php-mode)
(require 'flymake-php)
(require 'php-repl)

(load-library "php-electric")
(add-hook 'php-mode-hook '(lambda () (php-electric-mode)))

(setq php-manual-path "/usr/share/doc/php-docs-20071125-r2/ru"
      php-manual-url (concat "file://" php-manual-path))

(setq php-repl-program (concat (getenv "HOME") "/pear/php-repl"))

(defun my-php-mode-common-hook ()
  (c-toggle-auto-newline -1)
  (flymake-php-load)
  (setq c-basic-offset 4
				tab-width 4
				indent-tabs-mode nil))

(add-hook 'php-mode-hook 'my-php-mode-common-hook)

;;; emacs-rc-php.el ends here
